Handlebars.registerHelper 'x', (expression, options)->
  fn = ->

  try
    fn = -> Function.apply @, ['window', 'return ' + expression + ';']
  catch e
    console.warn "[warning] {{x #{expression}}} is invalid javascript", e

  try
    result = fn.call this, window
  catch e
    console.warn "[warning] {{x #{expression}}} is runtime error", e

  result