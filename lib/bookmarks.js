BookmarkCounts = new Meteor.Collection('bookmarkCounts');

Meteor.methods({
  'bookmarkPlace': function(placeName) {
    check(this.userId, String);
    check(placeName, String);

    var affected = Meteor.users.update({
      _id: this.userId,
      bookmarkedPlaceNames: {$ne: placeName}
    }, {
      $addToSet: {bookmarkedPlaceNames: placeName}
    });

    if (affected)
      BookmarkCounts.update({placeName: placeName}, {$inc: {count: 1}});
  },

  'unbookmarkPlace': function(placeName) {
    check(this.userId, String);
    check(placeName, String);

    var affected = Meteor.users.update({
      _id: this.userId,
      bookmarkedPlaceNames: placeName
    }, {
      $pull: {bookmarkedPlaceNames: placeName}
    });

    if (affected)
      BookmarkCounts.update({placeName: placeName}, {$inc: {count: -1}});
  }
});

// Initialize bookmark counts. We could use upsert instead.
if (Meteor.isServer && BookmarkCounts.find().count() === 0) {
  Meteor.startup(function() {
    _.each(PlacesData, function(place, placeName) {
      BookmarkCounts.insert({placeName: placeName, count: 0});
    });
  });
}