require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe FormularioCursosController do

  # This should return the minimal set of attributes required to create a valid
  # FormularioCurso. As you add validations to FormularioCurso, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "formulario_id" => "1" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FormularioCursosController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all formulario_cursos as @formulario_cursos" do
      formulario_curso = FormularioCurso.create! valid_attributes
      get :index, {}, valid_session
      assigns(:formulario_cursos).should eq([formulario_curso])
    end
  end

  describe "GET show" do
    it "assigns the requested formulario_curso as @formulario_curso" do
      formulario_curso = FormularioCurso.create! valid_attributes
      get :show, {:id => formulario_curso.to_param}, valid_session
      assigns(:formulario_curso).should eq(formulario_curso)
    end
  end

  describe "GET new" do
    it "assigns a new formulario_curso as @formulario_curso" do
      get :new, {}, valid_session
      assigns(:formulario_curso).should be_a_new(FormularioCurso)
    end
  end

  describe "GET edit" do
    it "assigns the requested formulario_curso as @formulario_curso" do
      formulario_curso = FormularioCurso.create! valid_attributes
      get :edit, {:id => formulario_curso.to_param}, valid_session
      assigns(:formulario_curso).should eq(formulario_curso)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new FormularioCurso" do
        expect {
          post :create, {:formulario_curso => valid_attributes}, valid_session
        }.to change(FormularioCurso, :count).by(1)
      end

      it "assigns a newly created formulario_curso as @formulario_curso" do
        post :create, {:formulario_curso => valid_attributes}, valid_session
        assigns(:formulario_curso).should be_a(FormularioCurso)
        assigns(:formulario_curso).should be_persisted
      end

      it "redirects to the created formulario_curso" do
        post :create, {:formulario_curso => valid_attributes}, valid_session
        response.should redirect_to(FormularioCurso.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved formulario_curso as @formulario_curso" do
        # Trigger the behavior that occurs when invalid params are submitted
        FormularioCurso.any_instance.stub(:save).and_return(false)
        post :create, {:formulario_curso => { "formulario_id" => "invalid value" }}, valid_session
        assigns(:formulario_curso).should be_a_new(FormularioCurso)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        FormularioCurso.any_instance.stub(:save).and_return(false)
        post :create, {:formulario_curso => { "formulario_id" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested formulario_curso" do
        formulario_curso = FormularioCurso.create! valid_attributes
        # Assuming there are no other formulario_cursos in the database, this
        # specifies that the FormularioCurso created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        FormularioCurso.any_instance.should_receive(:update_attributes).with({ "formulario_id" => "1" })
        put :update, {:id => formulario_curso.to_param, :formulario_curso => { "formulario_id" => "1" }}, valid_session
      end

      it "assigns the requested formulario_curso as @formulario_curso" do
        formulario_curso = FormularioCurso.create! valid_attributes
        put :update, {:id => formulario_curso.to_param, :formulario_curso => valid_attributes}, valid_session
        assigns(:formulario_curso).should eq(formulario_curso)
      end

      it "redirects to the formulario_curso" do
        formulario_curso = FormularioCurso.create! valid_attributes
        put :update, {:id => formulario_curso.to_param, :formulario_curso => valid_attributes}, valid_session
        response.should redirect_to(formulario_curso)
      end
    end

    describe "with invalid params" do
      it "assigns the formulario_curso as @formulario_curso" do
        formulario_curso = FormularioCurso.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FormularioCurso.any_instance.stub(:save).and_return(false)
        put :update, {:id => formulario_curso.to_param, :formulario_curso => { "formulario_id" => "invalid value" }}, valid_session
        assigns(:formulario_curso).should eq(formulario_curso)
      end

      it "re-renders the 'edit' template" do
        formulario_curso = FormularioCurso.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        FormularioCurso.any_instance.stub(:save).and_return(false)
        put :update, {:id => formulario_curso.to_param, :formulario_curso => { "formulario_id" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested formulario_curso" do
      formulario_curso = FormularioCurso.create! valid_attributes
      expect {
        delete :destroy, {:id => formulario_curso.to_param}, valid_session
      }.to change(FormularioCurso, :count).by(-1)
    end

    it "redirects to the formulario_cursos list" do
      formulario_curso = FormularioCurso.create! valid_attributes
      delete :destroy, {:id => formulario_curso.to_param}, valid_session
      response.should redirect_to(formulario_cursos_url)
    end
  end

end