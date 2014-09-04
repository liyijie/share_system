# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#photos_index").length > 0
    refresh_image = ->
      $.ajax
        type: 'get'
        dataType: 'json'
        url: '/photos/check.json'
        
        success: (result)->
          count = parseInt $("#photos_index").attr("count")
          last_id = parseInt $("#photos_index").attr("last_id")

          if count == result["count"] && last_id == result["last_id"]
            return
          window.location.href = "/photos"
    refresh_image()
    setInterval(refresh_image, 500)
  else if $("#photos_manage").length > 0
    $("#select").click -> 
      $(":checkbox").each (index, elm)->
        $(elm).prop("checked", true)
    $("#unselect").click -> 
      $(":checkbox").each (index, elm)->
        $(elm).prop("checked", false)

