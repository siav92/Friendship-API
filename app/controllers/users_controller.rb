# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /users
  def index
    users = User.full_text_search(params[:query])

    render json: users, status: :ok
  end

  # GET me/friends
  def friends
    render json: current_user.friendships, status: :ok
  end
end
