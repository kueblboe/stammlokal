Template.placeItem.helpers({
  path: function () {
    return Router.path('place', this.place);
  },
  
  highlightedClass: function () {
    if (this.size === 'large')
      return 'highlighted';
  },
  
  bookmarkCount: function () {
    var count = BookmarkCounts.findOne({placeName: this.name});
    return count && count.count;
  }
});