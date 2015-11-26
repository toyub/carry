class Mis.Time
  constructor: (date) ->
    @time = date

  @now = () ->
    new Time(new Date())

  beginningOfDay: ->
    @time = new Date(@time.getFullYear(), @time.getMonth(), @time.getDate())
    @

  endOfDay: ->
    @time = new Date(@time.getFullYear(), @time.getMonth(), @time.getDate() + 1, 0)
    @

  beginningOfMonth: ->
    @time = new Date(@time.getFullYear(), @time.getMonth(), 1)
    @

  endOfMonth: ->
    @time = new Date(@time.getFullYear(), @time.getMonth() + 1, 0)
    @

  beginningOfWeek: ->
    @time = new Date(@time.getFullYear(), @time.getMonth(), @time.getDate() - @time.getDay())
    @

  toString: ->
    @time.toString()

  toISOString: ->
    @time.toISOString()
