(function(win, doc, Backbone, $$MIS){
  var CommissionTemplateSectionCollection = Backbone.Collection.extend({
    model: $$MIS.CommissionTemplateSection
  });
  win.$$MIS = $$MIS || {};
  win.$$MIS.CommissionTemplateSectionCollection = CommissionTemplateSectionCollection;
})(window, document, Backbone, window.$$MIS);
