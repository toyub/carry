jQuery.validator.setDefaults({
  errorElement: "span",
  errorClass: "err",
  focusInvalid: false,
  errorPlacement: function(error,element){
    $('.error_tip').remove();
    error.addClass('error_tip');
    element.parent().append(error);
    console.log('done')
  },
  success: function(label,element){
    $('.error_tip').remove();
    console.log('success');
  }
});
