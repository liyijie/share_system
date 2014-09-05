# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Window.ScriptRun = 
  photos:
    index:
      init: ->
        redirect = false
        $("#main_manage_link").click ->
          redirect = true

        refresh_image = ->
          if redirect
            return
          $.ajax
            type: 'get'
            dataType: 'json'
            url: '/photos/check.json'

            success: (result)->
              count = parseInt $(".main_show_div").attr("count")
              last_id = parseInt $(".main_show_div").attr("last_id")

              if count == result["count"] && last_id == result["last_id"]
                return
              window.location.href = "/photos"

        refresh_image()
        setInterval(refresh_image, 500)
    manage:
      init: ->
        $("#select").click -> 
          $(":checkbox").each (index, elm)->
            $(elm).prop("checked", true)
        $("#unselect").click -> 
          $(":checkbox").each (index, elm)->
            $(elm).prop("checked", false)

