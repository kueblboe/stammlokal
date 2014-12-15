var TAB_KEY = 'placeShowTab';

Template.place.created = function() {
  if (Router.current().params.activityId)
    Template.place.setTab('feed');
  else
    Template.place.setTab('place');
}

Template.place.rendered = function () {
  this.$('.place').touchwipe({
    wipeDown: function () {
      if (Session.equals(TAB_KEY, 'place'))
        Template.place.setTab('make')
    },
    preventDefaultEvents: false
  });
  this.$('.attribution-place').touchwipe({
    wipeUp: function () {
      if (! Session.equals(TAB_KEY, 'place'))
        Template.place.setTab('place')
    },
    preventDefaultEvents: false
  });
}

// CSS transitions can't tell the difference between e.g. reaching
//   the "make" tab from the expanded state or the "feed" tab
//   so we need to help the transition out by attaching another
//   class that indicates if the feed tab should slide out of the
//   way smoothly, right away, or after the transition is over
Template.place.setTab = function(tab) {
  var lastTab = Session.get(TAB_KEY);
  Session.set(TAB_KEY, tab);
  
  var fromPlace = (lastTab === 'place') && (tab !== 'place');
  $('.feed-scrollable').toggleClass('instant', fromPlace);

  var toPlace = (lastTab !== 'place') && (tab === 'place');
  $('.feed-scrollable').toggleClass('delayed', toPlace);
}

Template.place.helpers({
  isActiveTab: function(name) {
    return Session.equals(TAB_KEY, name);
  },
  activeTabClass: function() {
    return Session.get(TAB_KEY);
  },
  bookmarked: function() {
    return Meteor.user() && _.include(Meteor.user().bookmarkedPlaceNames, this.name);
  }
});

Template.place.events({
  'click .js-add-bookmark': function(event) {
    event.preventDefault();

    if (! Meteor.userId())
      return Overlay.open('authOverlay');
    
    Meteor.call('bookmarkPlace', this.name);
  },

  'click .js-remove-bookmark': function(event) {
    event.preventDefault();

    Meteor.call('unbookmarkPlace', this.name);
  },
  
  'click .js-show-place': function(event) {
    event.stopPropagation();
    Template.place.setTab('make')
  },
  
  'click .js-show-feed': function(event) {
    event.stopPropagation();
    Template.place.setTab('feed')
  },
  
  'click .js-uncollapse': function() {
    Template.place.setTab('place')
  }
});