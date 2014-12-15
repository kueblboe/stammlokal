Template.bookmarks.helpers({
  placeCount: function() {
    return pluralize(this.length, 'place');
  }
});