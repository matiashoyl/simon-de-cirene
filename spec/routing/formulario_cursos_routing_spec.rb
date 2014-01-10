require "spec_helper"

describe FormularioCursosController do
  describe "routing" do

    it "routes to #index" do
      get("/formulario_cursos").should route_to("formulario_cursos#index")
    end

    it "routes to #new" do
      get("/formulario_cursos/new").should route_to("formulario_cursos#new")
    end

    it "routes to #show" do
      get("/formulario_cursos/1").should route_to("formulario_cursos#show", :id => "1")
    end

    it "routes to #edit" do
      get("/formulario_cursos/1/edit").should route_to("formulario_cursos#edit", :id => "1")
    end

    it "routes to #create" do
      post("/formulario_cursos").should route_to("formulario_cursos#create")
    end

    it "routes to #update" do
      put("/formulario_cursos/1").should route_to("formulario_cursos#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/formulario_cursos/1").should route_to("formulario_cursos#destroy", :id => "1")
    end

  end
end
