class TasksController < ApplicationController
 before_action :set_task, only: [:show, :edit, :update, :destroy]
 before_action :require_user_logged_in
 before_action :correct_user, only: [:destroy]
 
 def index
     @tasks = Task.all.page(params[:page]).per(10)
 end
 
 def show
 end
 
 def new
     @task = Task.new
 end
 
 def create
     @task = current_user.tasks.build(task_params)
     if @task.save
         flash[:success] = 'Taskが新規に追加されました'
         redirect_to root_url
     else
        @task = current_user.tasks.order(id: :desc).page(params[:page])
         flash.now[:danger] = 'Taskが投稿されませんでした'
         render 'tasks/index'
     end
 end
 
 def edit
 end
 
 def update
     
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
     redirect_back(fallback_location: root_path)
 end
 
private

 def correct_user
     @task = cuurent_user.tasks.find_by(id: params[:id])
     unless @task
     redirect_to root_url
     end
 end    

 def set_task
     @task = Task.find(params[:id])
 end

# Strong Parameter
 def task_params
     params.require(:task).permit(:content, :status)
 end

end