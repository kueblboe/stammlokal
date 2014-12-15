Meteor.publish "bookmarkCounts", ->
  BookmarkCounts.find()

Meteor.publish "place", (name) ->
  check name, String
  BookmarkCounts.find({placeName: name})

Meteor.publish "order", ->
  Orders.find {},
    sort:
      date: -1
    served: false


# autopublish the user's bookmarks and admin status
Meteor.publish null, ->
  Meteor.users.find @userId,
    fields:
      admin: 1
      bookmarkedPlaceNames: 1
      "services.twitter.profile_image_url_https": 1
