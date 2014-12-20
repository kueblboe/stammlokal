Meteor.publish "bookmarkCounts", ->
  BookmarkCounts.find()

Meteor.publish "place", (name) ->
  check name, String
  BookmarkCounts.find({placeName: name})

Meteor.publish "orders", ->
  Orders.find {userId: @userId, served: false}, {sort: {date: -1}}

Meteor.publish "ordersForMyPlace", ->
  myPlace = Meteor.users.findOne(@userId).myPlace
  Orders.find {placeName: myPlace, served: false}, {sort: {date: -1}}

# autopublish the user's bookmarks and admin status
Meteor.publish null, ->
  Meteor.users.find @userId,
    fields:
      admin: 1
      bookmarkedPlaceNames: 1
      myPlace: 1
      "services.twitter.profile_image_url_https": 1
