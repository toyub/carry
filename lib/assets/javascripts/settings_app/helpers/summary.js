summary_tmpl = JST['settings/commission_templates/new/summary'];
summary = function(model){
  return "<ul data-id=" + model.id + ">" + summary_tmpl(model) + "</ul>";
}
