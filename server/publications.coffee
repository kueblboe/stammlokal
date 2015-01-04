Meteor.publish "bookmarkCounts", ->
  BookmarkCounts.find()

Meteor.publish "place", (name) ->
  check name, String
  BookmarkCounts.find({placeName: name})

Meteor.publish "orders", ->
  Orders.find {userId: @userId}, {sort: {date: -1}}

Meteor.publish "ordersForMyPlace", ->
  myPlace = Meteor.users.findOne(@userId).myPlace
  Orders.find {placeName: myPlace}, {sort: {date: -1}}

# autopublish the user's bookmarks
Meteor.publish null, ->
  Meteor.users.find @userId,
    fields:
      bookmarkedPlaceNames: 1
      myPlace: 1
