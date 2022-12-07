# frozen_string_literal: true

class FriendshipsController < ApplicationController
  # POST /friendships
  def create
    friend = User.find_by!(email: friendship_params[:email])

    if (friendships = Friendships::Create.new(current_user, friend).run!)
      render json: friendships, status: :created
    else
      render json: friendships.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/1
  def destroy
    friendship = Friendship.find(params[:id])

    if Friendships::Unfriend.new(friendship).run!
      render json: { message: 'Unfriended successfully!' }, status: :ok
    else
      render json: { message: 'Unable to unfriended!' }, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:email)
  end
end
