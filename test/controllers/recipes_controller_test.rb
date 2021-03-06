require "test_helper"

describe RecipesController do
  it "should get index" do
    get root_path
    must_respond_with :success
  end

  it "should get a list of recipes" do
    VCR.use_cassette("get_recipes") do
        get get_recipes_path, params: {"search" => "chicken", page: "1"}
    end
      must_respond_with :success
    end

  it "should get an individual recipe" do
    VCR.use_cassette("get_recipe") do
      response = EdamamApiWrapper.findRecipes("chicken")[0]
      get get_recipe_path(response.label), params: {"uri" => response.uri}
    end
    must_respond_with :success
  end
end
