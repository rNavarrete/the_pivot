require 'rails_helper'

RSpec.describe OrderItemController, :type => :controller do

  describe "GET item_id:integer" do
    it "returns http success" do
      get :item_id:integer
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET order_id:integer" do
    it "returns http success" do
      get :order_id:integer
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET quantity:integer" do
    it "returns http success" do
      get :quantity:integer
      expect(response).to have_http_status(:success)
    end
  end

end
