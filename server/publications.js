Meteor.publish('bookmarkCounts', function() {
  return BookmarkCounts.find();
});

Meteor.publish('place', function(name) {
  check(name, String);
  return BookmarkCounts.find({placeName: name});
});

Meteor.publish('order', function() {
  return Orders.find({}, {sort: {date: -1}, served: false});
});

// autopublish the user's bookmarks and admin status
Meteor.publish(null, function() {
  return Meteor.users.find(this.userId, {
    fields: {
      admin: 1,
      bookmarkedPlaceNames: 1,
      'services.twitter.profile_image_url_https': 1
    }
  });
})