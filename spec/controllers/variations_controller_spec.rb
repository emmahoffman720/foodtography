require 'rails_helper'

RSpec.describe VariationsController, type: :controller do
  describe "variations#create action" do
    it "should allow users to create variations on posts" do
      p = FactoryGirl.create(:post)

      u = FactoryGirl.create(:user)
      sign_in u

      post :create, gram_id: p.id, variation: { title: 'recipe title', description: 'yummy' , recipe: 'ingredients' }

      expect(response).to redirect_to root_path
      expect(p.variations.length).to eq 1
      expect(p.variations.first.title).to eq "recipe title"
      expect(p.variations.first.description).to eq "yummy"
      expect(p.variations.first.recipe).to eq "ingredients"  
    end

    it "should require users to be logged in to create a variation on a post" do
      p = FactoryGirl.create(:post)
      post :create, gram_id: p.id, variation: { title: 'recipe title', description: 'yummy' , recipe: 'ingredients' }
      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the post is not found" do
      u = FactoryGirl.create(:user)
      sign_in u

      post :create, gram_id: 'NO_ID', variation: { title: 'recipe title', description: 'yummy' , recipe: 'ingredients' }

    end

  end

end
