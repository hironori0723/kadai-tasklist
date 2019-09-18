class TasksController < ApplicationController
 before_action :set_task, only: [:show, :edit, :update, :destroy]
 before_action :require_user_logged_in
 before_action :correct_user, only: [:update, :destroy]
 
 def index
     @tasks = current_user.tasks.page(params[:page]).per(10)
 end
 
 def show
 end
 
 def new
     @task = current_user.tasks.build
 end
 
 def create
     @task = current_user.tasks.build(task_params)
     if @task.save
         flash[:success] = 'Taskが新規に追加されました'
         redirect_to root_url
     else
         flash.now[:danger] = 'Taskが投稿されませんでした'
         render 'new'
     end
 end
 
 def edit
 end
 
 def update
     @task = current_user.tasks.build(task_params)
     if @task.update(task_params)
         flash[:success] = 'Taskの変更を保存しました'
         redirect_to @task
     else
         flash[:success] = 'Taskは更新されませんでした'
         render :edit
     end
 end
 
 def destroy
     @task.destroy
     flash[:success] = 'Taskは削除されました'
     redirect_to @task
 end
 
private

 def set_task
     @task = current_user.tasks.find(params[:id])
 end

# Strong Parameter
 def task_params
     params.require(:task).permit(:content, :status, :id)
 end

 def correct_user
     @task = current_user.tasks.find_by(id: params[:id])
     unless @task
     redirect_to root_url
     end
 end    
     
end