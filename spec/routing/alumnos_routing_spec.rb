require "spec_helper"

describe AlumnosController do
  describe "routing" do

    it "routes to #index" do
      get("/alumnos").should route_to("alumnos#index")
    end

    it "routes to #new" do
      get("/alumnos/new").should route_to("alumnos#new")
    end

    it "routes to #show" do
      get("/alumnos/1").should route_to("alumnos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/alumnos/1/edit").should route_to("alumnos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/alumnos").should route_to("alumnos#create")
    end

    it "routes to #update" do
      put("/alumnos/1").should route_to("alumnos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/alumnos/1").should route_to("alumnos#destroy", :id => "1")
    end

  end
end
