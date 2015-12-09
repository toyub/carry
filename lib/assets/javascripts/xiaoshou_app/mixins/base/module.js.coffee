# define module behavior
class Mis.Mixins.Module
  keywords = ['extended', 'included', 'initialize']

  @extend = (obj) ->
   for key, value of obj when key not in keywords
     @[key] = value
   obj.extended?.apply(@)
   this

  @include = (obj) ->
    for key, value of obj when key not in keywords
      @::[key] = value
    if obj.initialize?
      @::['_initialize_callbacks'] or= []
      @::['_initialize_callbacks'].push obj.initialize
    obj.included?.apply(@) if typeof obj.included is 'function'
    this

  initialize: ->
    if callbacks = @['_initialize_callbacks']
      cb.call(@) for cb in callbacks
