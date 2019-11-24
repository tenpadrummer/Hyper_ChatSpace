class UsersController < ApplicationController

  def index
    @users = User.where("(name LIKE(?)) and (id != ?)", "%#{params[:keyword]}%", "#{current_user.id}").where.not(id: params[:selected_user])
    respond_to do |format|
      format.json
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

  def selected_user
    selected_user =[]
    selected_user << current_user.id
    if params[:array]
      params[:array].map do |user_id|
        selected_user << user_id
      end
    end
  end
end
