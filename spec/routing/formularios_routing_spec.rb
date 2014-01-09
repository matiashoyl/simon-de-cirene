require "spec_helper"

describe FormulariosController do
  describe "routing" do

    it "routes to #index" do
      get("/formularios").should route_to("formularios#index")
    end

    it "routes to #new" do
      get("/formularios/new").should route_to("formularios#new")
    end

    it "routes to #show" do
      get("/formularios/1").should route_to("formularios#show", :id => "1")
    end

    it "routes to #edit" do
      get("/formularios/1/edit").should route_to("formularios#edit", :id => "1")
    end

    it "routes to #create" do
      post("/formularios").should route_to("formularios#create")
    end

    it "routes to #update" do
      put("/formularios/1").should route_to("formularios#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/formularios/1").should route_to("formularios#destroy", :id => "1")
    end

  end
end
