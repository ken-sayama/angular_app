module Api
  # NOTE 本来はApi::BaseControllerのようなAPIの共通コントローラーを継承すべき
  class TodoListsController < ApplicationController
    def show
      @todo_list = TodoList.find(params[:id])
    end
  end
end
