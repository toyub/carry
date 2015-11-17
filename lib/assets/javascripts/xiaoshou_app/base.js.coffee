# define Base classes for the application
Mis.Base =
  View: class BaseView extends Backbone.View
  Model: class BaseModel extends Backbone.Model
  Collection: class BaseCollection extends Backbone.Collection
  Router: class BaseRouter extends Backbone.Router

# let Base classes be modules
for name, klass of Mis.Base
  _(klass).extend Mis.Mixins.Module
  _(klass.prototype).extend Mis.Mixins.Module.prototype
