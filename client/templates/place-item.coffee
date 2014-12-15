Template.placeItem.helpers
  path: ->
    Router.path "place", @place

  highlightedClass: ->
    "highlighted"  if @size is "large"

  bookmarkCount: ->
    count = BookmarkCounts.findOne(placeName: @name)
    count and count.count
