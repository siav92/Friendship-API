class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[destroy]

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
    @friendship.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_friendship
    @friendship = Friendship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def friendship_params
    params.permit(:email)
  end
end
