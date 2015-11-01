@TodoMVC.module 'TodoList.Views', (Views, App, Backbone, Marionette, $, _)->
  Views.ItemView = Marionette.ItemView.extend
    tagName: 'li'
    template: '#template-todoItemView'
    ui:
      edit: '.edit'
    events:
      'click .destroy': 'destroy'
      'dbclick label': 'onEditClick'
      'keypress .edit': 'onEditKeypress'
      'click .toggle': 'toggle'
    initialize: ->
      @listenTo @model, 'change', @render
    onRender: ->
      @$el.removeClass 'active completed'
      if @model.get 'completed'
        @$el.addClass 'copleted'
      else
        @$el.addClass 'active'
    destroy: ->
      @model.destroy()
    toggle: ->
      @model.toggle().save()
    onEditClick: ->
      @$el.addClass 'editing'
      @ui.edit.focus()
    onEditKeypress: (evt)->
      ENTER_KEY = 13
      todoText = @ui.edit.val().trim()
      if evt.which is ENTER_KEY and todoText
        @model.set('title', todoText).save()
        @$el.removeClass 'editing'
  Views.ListView = Marionette.CompositeView.extend
    template: '#template-todoListCompositeView'
    itemView: Views.ItemView
    itemViewContainer: '#todo-list'
    ui:
      toggle: '#toggle-all'
    events:
      'click #toggle-all': 'onToggleAllClick'
    initialize: ->
      @listenTo @collection, 'all', @update
    onRender: ->
      @update()
    update: ->
      reduceCompleted = (left, right)->
        left and right.get 'completed'
      allCompleted = @collection.reduce reduceCompleted, true
      @ui.toggle.prop 'checked', allCompleted
      if @collection.length is 0
        @$el.parent().hide()
      else
        @$el.parent().show()
    onToggleAllClick: (evt)->
      isChecked = evt.currentTarget.checked
      @collection.each (todo)->
        todo.save
          completed: isChecked
  App.vent.on 'todoList:filter', (filter)->
    filter or= 'all'
    $ '#todoapp'
      .attr 'class', "filter-#{filter}"