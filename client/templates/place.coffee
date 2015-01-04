TAB_KEY = "placeShowTab"
TIME_KEY = "orderTime"

Template.place.helpers
  formattedPrice: ->
    "#{@price.toFixed(2).replace(/\./g, ',')} €"

Template.place.created = ->
  Template.place.setTab "place"
  Session.set TIME_KEY, 30

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

  isActiveTime: (minutes) ->
    Session.equals TIME_KEY, minutes

  bookmarked: ->
    Meteor.user() and _.include(Meteor.user().bookmarkedPlaceNames, @name)

Template.place.events
  "submit form": (e) ->
    e.preventDefault()
    text = $(e.target).find("#text").val()
    time = Session.get TIME_KEY

    Meteor.call "order", @name, text, time, (error) ->
      if error
        throwError error.reason
      else
        Router.go 'orders'

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
    Overlay.open('authOverlay') unless Meteor.user()

  "click .js-select-15": (event) ->
    event.stopPropagation()
    Session.set TIME_KEY, 15

  "click .js-select-30": (event) ->
    event.stopPropagation()
    Session.set TIME_KEY, 30

  "click .js-select-45": (event) ->
    event.stopPropagation()
    Session.set TIME_KEY, 45

  "click .js-select-60": (event) ->
    event.stopPropagation()
    Session.set TIME_KEY, 60

  "click .js-uncollapse": ->
    Template.place.setTab "place"
