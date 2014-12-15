ANIMATION_DURATION = 300
NOTIFICATION_TIMEOUT = 3000
MENU_KEY = "menuOpen"
SHOW_CONNECTION_ISSUE_KEY = "showConnectionIssue"
CONNECTION_ISSUE_TIMEOUT = 5000
Session.setDefault SHOW_CONNECTION_ISSUE_KEY, false
Session.setDefault MENU_KEY, false

# XXX: this work around until IR properly supports this
#   IR refactor will include Location.back, which will ensure that initator is
#   set 
nextInitiator = null
initiator = null
Deps.autorun ->
  
  # add a dep
  Router.current()
  initiator = nextInitiator
  nextInitiator = null

notifications = new Meteor.Collection(null)
Template.appBody.addNotification = (notification) ->
  id = notifications.insert(notification)
  Meteor.setTimeout (->
    notifications.remove id
  ), NOTIFICATION_TIMEOUT

Meteor.startup ->
  
  # set up a swipe left / right handler
  $(document.body).touchwipe
    wipeLeft: ->
      Session.set MENU_KEY, false

    wipeRight: ->
      Session.set MENU_KEY, true

    preventDefaultEvents: false

  
  # Only show the connection error box if it has been 5 seconds since
  # the app started
  setTimeout (->
    
    # Launch screen handle created in lib/router.js
    dataReadyHold.release()
    
    # Show the connection error box
    Session.set SHOW_CONNECTION_ISSUE_KEY, true
  ), CONNECTION_ISSUE_TIMEOUT

Template.appBody.rendered = ->
  @find("#content-container")._uihooks =
    insertElement: (node, next) ->
      
      # short-circuit and just do it right away
      return $(node).insertBefore(next)  if initiator is "menu"
      start = (if (initiator is "back") then "-100%" else "100%")
      $.Velocity.hook node, "translateX", start
      $(node).insertBefore(next).velocity
        translateX: [
          0
          start
        ]
      ,
        duration: ANIMATION_DURATION
        easing: "ease-in-out"
        queue: false


    removeElement: (node) ->
      return $(node).remove()  if initiator is "menu"
      end = (if (initiator is "back") then "100%" else "-100%")
      $(node).velocity
        translateX: end
      ,
        duration: ANIMATION_DURATION
        easing: "ease-in-out"
        queue: false
        complete: ->
          $(node).remove()

  @find(".notifications")._uihooks =
    insertElement: (node, next) ->
      $(node).insertBefore(next).velocity "slideDown",
        duration: ANIMATION_DURATION
        easing: [
          0.175
          0.885
          0.335
          1.05
        ]

    removeElement: (node) ->
      $(node).velocity "fadeOut",
        duration: ANIMATION_DURATION
        complete: ->
          $(node).remove()

Template.appBody.helpers
  menuOpen: ->
    Session.get(MENU_KEY) and "menu-open"

  overlayOpen: ->
    (if Overlay.isOpen() then "overlay-open" else "")

  connected: ->
    if Session.get(SHOW_CONNECTION_ISSUE_KEY)
      Meteor.status().connected
    else
      true

  notifications: ->
    notifications.find()

Template.appBody.events
  "click .js-menu": (event) ->
    event.stopImmediatePropagation()
    event.preventDefault()
    Session.set MENU_KEY, not Session.get(MENU_KEY)

  "click .js-back": (event) ->
    nextInitiator = "back"
    # XXX: set the back transition via Location.back() when IR 1.0 hits
    history.back()
    event.stopImmediatePropagation()
    event.preventDefault()

  "click a.js-open": (event) ->
    # On Cordova, open links in the system browser rather than In-App
    if Meteor.isCordova
      event.preventDefault()
      window.open event.target.href, "_system"

  "click .content-overlay": (event) ->
    Session.set MENU_KEY, false
    event.preventDefault()

  "click #menu a": (event) ->
    nextInitiator = "menu"
    Session.set MENU_KEY, false

  "click .js-notification-action": ->
    if _.isFunction(@callback)
      @callback()
      notifications.remove @_id
