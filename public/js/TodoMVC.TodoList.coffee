@TodoMVC.module 'TodoList', (TodoList, App, Backbone, Marionette, $, _)->

  TodoList.Router = Marionette.AppRouter.extend
    appRoutes:
      '*filter': 'filterItems'

  TodoList.Controller = ->
    @todoList = new App.Todos.TodoList()
  _.extend TodoList.Controller.prototype,
    start: ->
      @showHeader @todoList
      @showFooter @todoList
      @showTodoList @todoList
      @todoList.fetch()
    showHeader: (todoList)->
      header = new App.Layout.Header
        collection: todoList
      App.header.show header
    showFooter: (todoList)->
      footer = new App.Layout.Footer
        collection: todoList
      App.footer.show footer
    showTodoList: (todoList)->
      App.main.show new TodoList.Views.ListView
        collection: todoList
    filterItems: (filter)->
      App.vent.trigger 'todoList:filter', filter.trim() or ''

  TodoList.addInitializer ->
    controller = new TodoList.Controller()

    new TodoList.Router
      controller: controller
    controller.start()
