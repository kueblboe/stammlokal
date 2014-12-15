TEMPLATE_KEY = "overlayTemplate"
DATA_KEY = "overlayData"
ANIMATION_DURATION = 200
Session.setDefault TEMPLATE_KEY, null

@Overlay =
  open: (template, data) ->
    Session.set TEMPLATE_KEY, template
    Session.set DATA_KEY, data

  close: ->
    Session.set TEMPLATE_KEY, null
    Session.set DATA_KEY, null

  isOpen: ->
    not Session.equals(TEMPLATE_KEY, null)

  template: ->
    Session.get TEMPLATE_KEY

  data: ->
    Session.get DATA_KEY

Template.overlay.rendered = ->
  @find("#overlay-hook")._uihooks =
    insertElement: (node, next, done) ->
      $node = $(node)
      $node.hide().insertBefore(next).velocity "fadeIn",
        duration: ANIMATION_DURATION

    removeElement: (node, done) ->
      $node = $(node)
      $node.velocity "fadeOut",
        duration: ANIMATION_DURATION
        complete: ->
          $node.remove()

Template.overlay.helpers
  template: ->
    Overlay.template()

  data: ->
    Overlay.data()

Template.overlay.events "click .js-close-overlay": (event) ->
  event.preventDefault()
  Overlay.close()
