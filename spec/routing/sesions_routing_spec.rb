require "spec_helper"

describe SesionsController do
  describe "routing" do

    it "routes to #index" do
      get("/sesions").should route_to("sesions#index")
    end

    it "routes to #new" do
      get("/sesions/new").should route_to("sesions#new")
    end

    it "routes to #show" do
      get("/sesions/1").should route_to("sesions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/sesions/1/edit").should route_to("sesions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/sesions").should route_to("sesions#create")
    end

    it "routes to #update" do
      put("/sesions/1").should route_to("sesions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/sesions/1").should route_to("sesions#destroy", :id => "1")
    end

  end
end
