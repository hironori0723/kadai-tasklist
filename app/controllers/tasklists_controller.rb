class TasklistsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'task/index'
    end
  end

  def destroy
  end

  private

  def task_params
    params.require(:task).permit(:content)
  end
end