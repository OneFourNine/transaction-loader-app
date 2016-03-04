refresh = ->
  $.ajax({
    url: '/status',
    success: (data) ->
      window.location.href = '/transactions' unless data.locked_tenant
  })
  setTimeout(refresh, 5000);

$(window).load ->
  setTimeout(refresh, 5000);
