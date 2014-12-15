var feedSubscription;

// Handle for launch screen possibly dismissed from app-body.js
dataReadyHold = null;

// Global subscriptions
if (Meteor.isClient) {
  Meteor.subscribe('bookmarkCounts');
}

Router.configure({
  layoutTemplate: 'appBody',
  notFoundTemplate: 'notFound'
});

if (Meteor.isClient) {
  // Keep showing the launch screen on mobile devices until we have loaded
  // the app's data
  dataReadyHold = LaunchScreen.hold();
}

PlacesController = RouteController.extend({
  data: function() {
    return _.values(PlacesData);
  }
});

BookmarksController = RouteController.extend({
  onBeforeAction: function() {
    if (Meteor.user())
      Meteor.subscribe('bookmarks');
    else
      Overlay.open('authOverlay');
  },
  data: function() {
    if (Meteor.user())
      return _.values(_.pick(PlacesData, Meteor.user().bookmarkedPlaceNames));
  }
});

PlaceController = RouteController.extend({
  onBeforeAction: function() {
    Meteor.subscribe('place', this.params.name);
  },
  data: function() {
    return PlacesData[this.params.name];
  }
});

Router.map(function() {
  this.route('places', {path: '/'});
  this.route('bookmarks');
  this.route('about');
  this.route('place', {path: '/places/:name'});
  this.route('admin', { layoutTemplate: null });
});

Router.onBeforeAction('dataNotFound', {only: 'place'});