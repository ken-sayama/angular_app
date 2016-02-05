angular.module('sampleApp').controller "TodoListCtrl", ($scope, TodoList, Todo) ->

  # 初期データを用意するメソッド
  # $scope.list.name  としてアクセスできる
  # $scope.list.todos としてアクセスできる
  $scope.init = ->
    @todoListService = new TodoList(serverErrorHandler)
    @todoService = new Todo(1, serverErrorHandler)

    # データを取得する(GET /api/todo_lists/:id => Api::TodoLists#show)
    $scope.list = @todoListService.find(1)

  $scope.addTodo = (todoDescription) ->

    # todoを追加する(POST /api/todo_lists/:todo_list_id/todos => Api::Todo#destroy)
    todo = @todoService.create(description: todoDescription, completed: false)
    # initメソッドで用意したtodosの一番最初にtodoを追加する
    $scope.list.todos.unshift(todo)
    console.log(todo.description + 'が追加されました。')
    # todo入力テキストフィールドを空にする
    $scope.todoDescription = ""

  $scope.deleteTodo = (todo) ->
    # todoをサービスから削除する(DELETE /api/:todo_lists/todo_list_id/todos/:id => Api::Todo#destroy)
    @todoService.delete(todo)
    # todoをangularJSのlistデータから削除する(indexOfメソッドでtodoのindexを探し、spliceメソッドで削除する)
    $scope.list.todos.splice($scope.list.todos.indexOf(todo), 1)
    console.log "削除されました。"

  serverErrorHandler = ->
    alert("サーバーエラーが発生しました")
