class GroupsController < ApplicationController
  before_action :set_group, only: %i[edit update destroy remove_user]

  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_url, notice: 'グループを作成しました'
    else
      render 'new'
    end
  end

  def update
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: 'グループを編集しました'
    else
      render 'edit'
    end
  end

  def destroy
    if @group.destroy
      redirect_to root_path, notice: 'グループを削除しました'
    else
      render template: 'message/index'
    end
  end

  def remove_user
    group_users = @group.users
    if group_users.destroy(current_user)
      redirect_to root_path, notice: 'グループを退会しました'
    else
      render template: 'message/index'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, { user_ids: [] })
  end

  def set_group
    @group = Group.find(params[:id])
  end
end
