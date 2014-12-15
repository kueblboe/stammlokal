Template.nav.rendered = ->
  $nav = @$("nav")
  $nav.siblings(".content-scrollable:not(.static-nav)").children().first().waypoint ((direction) ->
    $nav.toggleClass "scrolled", direction is "down"
  ),
    context: ".content-scrollable"
    offset: -200


# Iron Router stores {initial: true} in history state if this is
# the first route that we hit in an app. There are a variety of 
# unexpected ways that this can happen (for example oauth, or 
# hot code push), but we can't rely on going back in such cases.
Template.nav.helpers back: ->
  @back and not history.state.initial
