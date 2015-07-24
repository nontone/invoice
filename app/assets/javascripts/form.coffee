ready = ->
  $('[data-form]').on 'click', ->
    form = $(@).data('form')
    $(form).submit()

$(document).ready(ready)
$(document).on('page:load', ready)