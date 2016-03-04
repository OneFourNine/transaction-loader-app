validate = ->
  if $('.pass_input').val().length > 0 && $('.username_input').val().length > 0
    $('.pass_submit').prop 'disabled', false
  else
    $('.pass_submit').prop 'disabled', true

$ ->
  validate()
  $('form input').keyup validate
