require "spec_helper"

describe PayeesController do
  describe "routing" do

    it "routes to #index" do
      get("/payees").should route_to("payees#index")
    end

    it "routes to #new" do
      get("/payees/new").should route_to("payees#new")
    end

    it "routes to #show" do
      get("/payees/1").should route_to("payees#show", :id => "1")
    end

    it "routes to #edit" do
      get("/payees/1/edit").should route_to("payees#edit", :id => "1")
    end

    it "routes to #create" do
      post("/payees").should route_to("payees#create")
    end

    it "routes to #update" do
      put("/payees/1").should route_to("payees#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/payees/1").should route_to("payees#destroy", :id => "1")
    end

  end
end
