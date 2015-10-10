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
//= require jquery.validate
//= require jquery.form
//= require jquery.serializejson
//= require jquery.validate_ext
//= require jquery.alert
//= require menu
//= require underscore
//= require backbone
//= require backbone-validation-min
//= require backbone-ext
//= require 'piccut/1.0.0'
//= require 'select2'
//= require mis
//= require_tree ../templates
//= require_tree ./models
//= require_tree ./collections
//= require_tree ./views
//= require_tree ./routers
//= require base/close
//= require extjs/ext-all
//= require extjs/ext-locale-zh_CN
//= require extjs_app/actioncolumn_patch
//= require xianchang/pre_order


function ZhanchuangAlert(msg) {
  $.alert({text: msg})
}
