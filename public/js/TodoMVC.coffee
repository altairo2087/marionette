@TodoMVC = new Marionette.Application()
@TodoMVC.addRegions
  header: '#header'
  main: '#main'
  footer: '#footer'
@TodoMVC.on 'initialize:after', ->
  Backbone.history.start()