Handlebars.registerHelper 'xif', (expression, options)->
  if Handlebars.helpers['x'].apply @, [expression, options] then options.fn @ else options.inverse @