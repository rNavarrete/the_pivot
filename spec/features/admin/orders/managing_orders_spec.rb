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
      canceled = Order.create(status: "canceled", user_id: user.id)
      completed = Order.create(status: "completed", user_id: user.id)
      ordered   = Order.create(status: "ordered", user_id: user.id)

      visit admin_orders_path

      within('#orders') do
        expect(page).to have_content paid.status
        expect(page).to have_content canceled.status
        expect(page).to have_content completed.status
        expect(page).to have_content ordered.status
      end
    end

    scenario "viewing paid orders" do
      paid      = Order.create(status: "paid", user_id: user.id)
      canceled  = Order.create(status: "canceled", user_id: user.id)
      completed = Order.create(status: "completed", user_id: user.id)
      ordered   = Order.create(status: "ordered", user_id: user.id)

      visit admin_orders_path
      click_link "Paid (1)"

      within('#orders') do
        expect(page).to     have_content paid.status
        expect(page).not_to have_content canceled.status
        expect(page).not_to have_content completed.status
        expect(page).not_to have_content ordered.status
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
      Order.create(status: 'ordered', user_id: user.id)
      user2 = User.create(full_name: 'Jane', email_address: 'jane@example.com', password: '1234', password_confirmation: '1234', role: 'admin')

      Order.create(status: 'canceled', user_id: user2.id)
      Order.create(status: 'paid',     user_id: user2.id)
      visit admin_orders_path

      expect(page).to have_link "Ordered (2)"
      expect(page).to have_link "Paid (1)"
      expect(page).to have_link "Canceled (1)"

      click_link('Ordered (2)')

      expect(page).to have_text "John"
      expect(page).to_not have_text "Jane"
      click_link('View All Orders')
      expect(page).to have_text "John"
      expect(page).to have_text "Jane"
    end

    scenario "can change status of order from ordered to canceled" do
      order = Order.create(status: 'ordered', user_id: user.id)
      visit admin_orders_path
      click_button 'Cancel'
      expect(page).to have_text 'Canceled (1)'
    end
  end
end
