Backbone.Model::toJSON = () ->
  hashWithRoot = {}
  if @modelName
    hashWithRoot[@modelName] = @attributes
    _.clone(hashWithRoot)
  else
    _.clone(@attributes)
