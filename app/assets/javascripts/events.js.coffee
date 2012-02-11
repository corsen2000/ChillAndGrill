# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  if $("#event_private")[0].checked
  	toggle_user_selection()
  $('#event_private').bind 'click', toggle_user_selection

toggle_user_selection = ->
	if $("#event_private")[0].checked
		$('#user_selection_container').show()
	else
		$('#user_selection_container').hide()