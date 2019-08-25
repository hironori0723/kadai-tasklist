class TasksController < ApplicationController
 def index
     @tasks = Task.all
 end
 
 def show
     @task = Task.find(params[:id])
 end
 
 def new
     @task = Task.new
 end
 
 def create
     @task = Task.new(task_params)
     
     if @task.save
         flash[:success] = 'Taskが新規に追加されました'
         redirect_to @task
     else
         flash.now[:render] = 'Taskがリミットに達しています'
         render :new
     end
 end
 
 def edit
     @task = Task.find(params[:id])
 end
 
 def update
     @task = Task.find(params[:id])
     
     if @task.update(task_params)
         flash[:success] = 'Taskの変更を保存しました'
         redirect_to @task
     else
         flash[:success] = 'このTaskは変更できません'
         render :edit
     end
 end
 
 def destroy
     @task = Task.find(params[:id])
     @task.destroy
     
     flash[:success] = 'Taskは削除されました'
     redirect_to tasks_url
 end
 
private

# Strong Parameter
 def task_params
     params.require(:task).permit(:content)
 end

end