@TodoMVC.module 'Layout', (Layout, App, Backbone, Marionette, $, _)->
  Layout.Header = Marionette.ItemView.extend
    template: '#template-header'
    ui:
      input: '#new-todo'
    events:
      'keypress #new-todo': 'onInputKeypress'
    onInputKeypress: (evt)->
      ENTER_KEY = 13
      todoText = @ui.input.val().trim()
      if evt.which is ENTER_KEY and todoText
        @collection.create
          title: todoText
        @ui.input.val ''
  Layout.Footer = Marionette.Layout.extend
    template: '#template-footer'
    ui:
      count: '#todo-count strong'
      filters: '#filters a'
    events:
      'click #clear-completed': 'onClearClick'
    initialize: ->
      @listenTo App.vent, 'todoList:filter', @updateFilterSelection
      @listenTo @collection, 'all', @updateCount
    onRender: ->
      @updateCount()
    updateCount: ->
      count = @collection.getActive().length
      @ui.count.html count
      if count is 0 then @$el.parent().hide() else @$el.parent().show()
    updateFilterSelection: (filter)->
      @ui.filters
        .removeClass 'selected'
        .filter "[href='##{filter}']"
        .addClass 'selected'
    onClearClick: ->
      completed = @collection.getCompleted()
      completed.forEach (todo)->
        todo.destroy()