# frozen_string_literal: true

class UsersController < ApplicationController
  # GET /users
  def index
    users = User.all

    render json: users, status: :ok
  end

  # GET /friends
  def friends
    render json: current_user.friends, status: :ok
  end
end
