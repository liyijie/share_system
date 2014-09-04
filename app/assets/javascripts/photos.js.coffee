# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
count = 0
last_id = 0
$ ->
  refresh_image = ->
    $.ajax
      type: 'get'
      dataType: 'json'
      url: 'photos/check.json'
      
      success: (result)->
        if count == result["count"] && last_id == result["last_id"]
          return
        count = result["count"]
        last_id = result["last_id"]


  refresh_image()
  setInterval(refresh_image, 500)
