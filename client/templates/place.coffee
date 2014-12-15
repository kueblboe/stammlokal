TAB_KEY = "placeShowTab"
Template.place.created = ->
  if Router.current().params.activityId
    Template.place.setTab "feed"
  else
    Template.place.setTab "place"

Template.place.rendered = ->
  @$(".place").touchwipe
    wipeDown: ->
      Template.place.setTab "make"  if Session.equals(TAB_KEY, "place")

    preventDefaultEvents: false

  @$(".attribution-place").touchwipe
    wipeUp: ->
      Template.place.setTab "place"  unless Session.equals(TAB_KEY, "place")

    preventDefaultEvents: false

# CSS transitions can't tell the difference between e.g. reaching
#   the "make" tab from the expanded state or the "feed" tab
#   so we need to help the transition out by attaching another
#   class that indicates if the feed tab should slide out of the
#   way smoothly, right away, or after the transition is over
Template.place.setTab = (tab) ->
  lastTab = Session.get(TAB_KEY)
  Session.set TAB_KEY, tab
  fromPlace = (lastTab is "place") and (tab isnt "place")
  $(".feed-scrollable").toggleClass "instant", fromPlace
  toPlace = (lastTab isnt "place") and (tab is "place")
  $(".feed-scrollable").toggleClass "delayed", toPlace

Template.place.helpers
  isActiveTab: (name) ->
    Session.equals TAB_KEY, name

  activeTabClass: ->
    Session.get TAB_KEY

  bookmarked: ->
    Meteor.user() and _.include(Meteor.user().bookmarkedPlaceNames, @name)

Template.place.events
  "click .js-add-bookmark": (event) ->
    event.preventDefault()
    return Overlay.open("authOverlay")  unless Meteor.userId()
    Meteor.call "bookmarkPlace", @name

  "click .js-remove-bookmark": (event) ->
    event.preventDefault()
    Meteor.call "unbookmarkPlace", @name

  "click .js-show-place": (event) ->
    event.stopPropagation()
    Template.place.setTab "make"

  "click .js-show-feed": (event) ->
    event.stopPropagation()
    Template.place.setTab "feed"

  "click .js-uncollapse": ->
    Template.place.setTab "place"
