$ ->
  	if $('#event_private').length
    	toggle_user_selection()
    	$('#event_private').bind 'click', toggle_user_selection

toggle_user_selection = ->
	if $("#event_private")[0].checked
		$('#user_selection_container').show()
	else
		$('#user_selection_container').hide()