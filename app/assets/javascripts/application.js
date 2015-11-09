// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery/2.1.3.min
//= require jquery_ujs/1.0.3
//= require jquery_ui/1.11.2
//= require titletip/1.0.0
//= require js-routes
//= require jquery_validate/1.14.0
//= require jquery_form/3.51.0
//= require jquery_serializejson/2.6.1
//= require jquery_ext/jquery.validate_ext
//= require jquery_ext/jquery.alert
//= require jquery_ext/jquery.confirm
//= require menu
//= require underscore
//= require underscore_string/3.2.2
//= require backbone
//= require backbone_validation/0.11.5
//= require backbone_ext/model.tojson
//= require 'piccut/1.0.0'
//= require 'select2'
//= require number_input
//= require uploader/image
//= require dialogs/upload

function ZhanchuangAlert(msg) {
  $.alert({text: msg})
}
