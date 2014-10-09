require "rails_helper"
require 'capybara/rails'
require 'capybara/rspec'

feature "Managing Orders" do
  context "as an anonymous user" do
    scenario "trying to access the orders page" do
      visit admin_orders_path
      expect(page.current_path).to eq(root_path)
    end
  end

  context "as an admin user" do
    given!(:user) {
      user = user_with({})
      user.save
      user
    }

    before do
      login_as(user)
    end

    scenario "trying to access the orders page" do
      visit admin_orders_path
      expect(page.current_path).to eq(admin_orders_path)
    end

    scenario "viewing orders" do
      paid      = Order.create(status: "paid", user_id: user.id)
      cancelled = Order.create(status: "cancelled", user_id: user.id)
      completed = Order.create(status: "completed", user_id: user.id)
      ordered   = Order.create(status: "ordered", user_id: user.id)

      visit admin_orders_path

      within('#orders') do
        expect(page).to have_content paid.id
        expect(page).to have_content cancelled.id
        expect(page).to have_content completed.id
        expect(page).to have_content ordered.id
      end
    end

    scenario "viewing paid orders" do
      paid      = Order.create(status: "paid", user_id: user.id)
      cancelled = Order.create(status: "cancelled", user_id: user.id)
      completed = Order.create(status: "completed", user_id: user.id)
      ordered   = Order.create(status: "ordered", user_id: user.id)

      visit admin_orders_path

      click_link "Paid (1)"

      within('#orders') do
        expect(page).to     have_content paid.id
        expect(page).not_to have_content cancelled.id
        expect(page).not_to have_content completed.id
        expect(page).not_to have_content ordered.id
      end
    end

    scenario "viewing the paid filter with a paid order" do
      Order.create(status: 'paid', user_id: user.id)
      visit admin_orders_path
      expect(page).to have_link "Paid (1)"
    end

    scenario "viewing the paid filter without a paid order" do
      visit admin_orders_path
      expect(page).to have_link "Paid (0)"
    end

    scenario "viewing the completed filter with a completed order" do
      Order.create(status: 'completed', user_id: user.id)
      visit admin_orders_path
      expect(page).to have_link "Completed (1)"
    end

    scenario "viewing the completed filter with a completed order" do
      visit admin_orders_path
      expect(page).to have_link "Completed (0)"
    end

    scenario "viewing the canceled filter with a canceled order" do
      Order.create(status: 'canceled', user_id: user.id)
      visit admin_orders_path
      expect(page).to have_link "Canceled (1)"
    end

    scenario "viewing the canceled filter with a canceled order" do
      visit admin_orders_path
      expect(page).to have_link "Canceled (0)"
    end

    scenario "viewing the ordered filter with a ordered order" do
      Order.create(status: 'ordered', user_id: user.id)
      visit admin_orders_path
      expect(page).to have_link "Ordered (1)"
    end

    scenario "viewing the ordered filter with a ordered order" do
      visit admin_orders_path
      expect(page).to have_link "Ordered (0)"
    end

    scenario "clicking all will allow you to view page with all orders again" do
      Order.create(status: 'ordered', user_id: user.id)
      Order.create(status: 'canceled', user_id: user.id)
      Order.create(status: 'ordered', user_id: user.id)
      Order.create(status: 'paid', user_id: user.id)
      visit admin_orders_path
      expect(page).to have_link "Ordered (2)"
      expect(page).to have_link "Paid (1)"
      expect(page).to have_link "Canceled (1)"

      click_link('Ordered (2)')

      expect(page).to have_text "13 - John"
      click_link('View All Orders')
      expect(page).to have_text "14 - John"


    end
  end
end
