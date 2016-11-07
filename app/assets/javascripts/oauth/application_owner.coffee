# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  do ->
    replaceSelectOptions = ($select, results) ->
      $select.html $('<option>')
      $.each results, ->
        optionlabel = "[ " + this.name + " ] " + this.label
        option = $('<option>').val(this.id).text(optionlabel)
        $select.append(option)

    replaceChildrenOptions = ->
      childrenPath = $(@).find('option:selected').data().childrenPath
      $selectChildren = $(@).closest('form').find('#application_owner_owner_id')
      if childrenPath?
        $.ajax
          url: childrenPath
          dataType: "json"
          success: (results) ->
            replaceSelectOptions($selectChildren, results)
          error: (XMLHttpRequest, textStatus, errorThrown) ->
            console.error("Error occurred in replaceChildrenOptions")
            console.log("XMLHttpRequest: #{XMLHttpRequest.status}")
            console.log("textStatus: #{textStatus}")
            console.log("errorThrown: #{errorThrown}")
      else
        replaceSelectOptions($selectChildren, [])

    $('#provider').on
       'change': replaceChildrenOptions

       