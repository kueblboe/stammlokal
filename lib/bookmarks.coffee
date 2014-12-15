@BookmarkCounts = new Meteor.Collection("bookmarkCounts")

Meteor.methods
  bookmarkPlace: (placeName) ->
    check @userId, String
    check placeName, String
    affected = Meteor.users.update(
      _id: @userId
      bookmarkedPlaceNames:
        $ne: placeName
    ,
      $addToSet:
        bookmarkedPlaceNames: placeName
    )
    if affected
      BookmarkCounts.update
        placeName: placeName
      ,
        $inc:
          count: 1

  unbookmarkPlace: (placeName) ->
    check @userId, String
    check placeName, String
    affected = Meteor.users.update(
      _id: @userId
      bookmarkedPlaceNames: placeName
    ,
      $pull:
        bookmarkedPlaceNames: placeName
    )
    if affected
      BookmarkCounts.update
        placeName: placeName
      ,
        $inc:
          count: -1


# Initialize bookmark counts. We could use upsert instead.
if Meteor.isServer and BookmarkCounts.find().count() is 0
  Meteor.startup ->
    _.each PlacesData, (place, placeName) ->
      BookmarkCounts.insert
        placeName: placeName
        count: 0
