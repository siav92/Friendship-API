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

  # PATCH /friendships/:friendship_id/accept
  def accept
    if Friendships::Accept.new(friendship).run!
      render json: { message: 'Friendship accepted!' }, status: :ok
    else
      render json: { message: 'Unable to accept friendship!' }, status: :unprocessable_entity
    end
  end

  #  PATCH /friendships/:id
  def unfriend
    if Friendships::Unfriend.new(friendship).run!
      render json: { message: 'Unfriended successfully!' }, status: :ok
    else
      render json: { message: 'Unable to unfriended!' }, status: :unprocessable_entity
    end
  end

  private

  def friendship
    @friendship ||= Friendship
                    .joins(:friend)
                    .find_by!(
                      users: { email: friendship_params[:email] },
                      friendships: { user_id: current_user.id }
                    )
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:email)
  end
end
