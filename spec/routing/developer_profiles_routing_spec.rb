require "spec_helper"

describe DeveloperProfilesController do
  describe "routing" do

    it "routes to #index" do
      get("/developer_profiles").should route_to("developer_profiles#index")
    end

    it "routes to #new" do
      get("/developer_profiles/new").should route_to("developer_profiles#new")
    end

    it "routes to #show" do
      get("/developer_profiles/1").should route_to("developer_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/developer_profiles/1/edit").should route_to("developer_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/developer_profiles").should route_to("developer_profiles#create")
    end

    it "routes to #update" do
      put("/developer_profiles/1").should route_to("developer_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/developer_profiles/1").should route_to("developer_profiles#destroy", :id => "1")
    end

  end
end
