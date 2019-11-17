class UsersController < ApplicationController

  def index
    if params[:groupId].present?
      @group = Group.find(params[:groupId])
      @user_ids = @group.users.ids
      @users = User.where.not(id: @user_ids).where("(name LIKE(?)) and (id != ?)", "%#{params[:keyword]}%", "#{current_user.id}")
    else
      @users = User.where("(name LIKE(?)) and (id != ?)", "%#{params[:keyword]}%", "#{current_user.id}")
    end
    respond_to do |format|
      format.json{render json: @users}
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_url
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
