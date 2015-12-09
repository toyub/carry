jQuery.validator.setDefaults(
  errorElement: "span"
  errorClass: "err"
  focusInvalid: false
  errorPlacement: (error,element) ->
    $(element).parent().find('.error_tip').remove()
    error.addClass('error_tip')
    element.parent().append(error)
    console.log('error')
  success: (label,element) ->
    $(element).parent().find('.error_tip').remove()
    console.log('success')
)
