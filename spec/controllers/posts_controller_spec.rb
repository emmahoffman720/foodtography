require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "posts#update" do
    it "should allow users to successfully update posts" do
      p = FactoryGirl.create(:post, message: 'Initial Value', recipe: 'Ingredients')
      patch :update, id: p.id, post: {message: "Changed", recipe: "Changed"}
      p.reload
      expect(p.message).to eq "Changed"
      expect(p.recipe).to eq "Changed"
    end

    it "should have http 404 error if the post cannot be found" do
      patch :update, id: "RANDOMID", post: {message: "Changed", recipe: "Changed"}
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      p = FactoryGirl.create(:post, message: 'Initial Value', recipe: 'Ingredients')
      patch :update, id: p.id, post: {message: '', recipe: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      p.reload
      expect(p.message).to eq "Initial Value"
      expect(p.recipe).to eq "Ingredients"
    end
  end

  describe "posts#edit" do
    it "should successfully show the edit form if the post is found" do
      p = FactoryGirl.create(:post)
      get :edit, id: p.id
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error message if the post is not found" do
      get :edit, id: 'RANDOM'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#show action" do
    it "should successfully show the page if the post is found" do
      post = FactoryGirl.create(:post)
      get :show, id: post.id
      expect(response).to have_http_status(:success)
    end
    
    it "should return a 404 error if the post is not found" do
      get :show, id: 'IDK'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "posts#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)

    end
  end

  describe "posts#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = FactoryGirl.create(:user)
      sign_in user      

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "posts#create action" do
    it "should require users to be logged in" do
      post :create, post: { message: "First Recipe" }
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully create a new post in database" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post: {message: 'First Recipe', recipe: 'Bread, peanut butter, jelly'}
      expect(response).to redirect_to root_path

      post = Post.last
      expect(post.message).to eq("First Recipe")
      expect(post.recipe).to eq("Bread, peanut butter, jelly")
      expect(post.user).to eq(user)
    end

    it "should successfully deal with validation errors" do
      user = FactoryGirl.create(:user)
      sign_in user

      post :create, post: {message: ''}
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Post.count).to eq 0
    end
  end

end
