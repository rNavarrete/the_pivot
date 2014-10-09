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
  end
end
