Template.admin.helpers
  isAdmin: ->
    Meteor.user() and Meteor.user().admin

  latestNews: ->
    News.latest()

Template.admin.events
  "submit form": (event) ->
    event.preventDefault()
    text = $(event.target).find("[name=text]").val()
    News.insert
      text: text
      date: new Date

    alert "Saved latest news"

  "click .login": ->
    Meteor.loginWithTwitter()
