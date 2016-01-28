window.Mis =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Helpers: {}
  Vues: {
    Orders:{
      Items:{}
    },
    Opts: {}
  }
  Components:{
    Order: {
      removeItem: (e)->
        orderable_id = $(e.target).data("orderableid")
        _this = this;
        $.grep this.items, (item)->
          if item.orderable_id == orderable_id
            _this.items.pop(item)
    }
  }

  initialize: ->

$(document).ready ->
  Mis.initialize()
