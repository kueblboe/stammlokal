@pluralize = (n, thing, options) ->
  plural = thing
  if _.isUndefined(n)
    return thing
  else if n isnt 1
    if thing.slice(-1) is "s"
      plural = thing + "es"
    else
      plural = thing + "s"
  if options and options.hash and options.hash.wordOnly
    plural
  else
    n + " " + plural

Handlebars.registerHelper "pluralize", pluralize
DIMENSIONS =
  small: "320x350"
  large: "640x480"
  full: "640x800"

UI.registerHelper "placeImage", (options) ->
  size = options.hash.size or "large"
  "/img/places/" + DIMENSIONS[size] + "/" + options.hash.place.name + ".jpg"  if options.hash.place

Handlebars.registerHelper "activePage", ->
  
  # includes Spacebars.kw but that's OK because the route name ain't that.
  routeNames = arguments
  _.include(routeNames, Router.current().route.name) and "active"

