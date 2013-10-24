require "spec_helper"

describe CustomerTransactionsController do
  describe "routing" do

    it "routes to #index" do
      get("/customer_transactions").should route_to("customer_transactions#index")
    end

    it "routes to #new" do
      get("/customer_transactions/new").should route_to("customer_transactions#new")
    end

    it "routes to #show" do
      get("/customer_transactions/1").should route_to("customer_transactions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/customer_transactions/1/edit").should route_to("customer_transactions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/customer_transactions").should route_to("customer_transactions#create")
    end

    it "routes to #update" do
      put("/customer_transactions/1").should route_to("customer_transactions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/customer_transactions/1").should route_to("customer_transactions#destroy", :id => "1")
    end

  end
end
