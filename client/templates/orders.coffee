Template.orders.helpers
  orders: ->
    Orders.find({}, {sort: {arrivalTime: 1}})

  isMyPlace: ->
    @placeName is Meteor.user().myPlace

  unconfirmedForMyPlace: ->
    @placeName is Meteor.user().myPlace and not @confirmed


  isMyOrder: ->
    @userId is Meteor.userId()

  isoDate: ->
    @arrivalTime.toISOString()

  time: ->
    moment(@arrivalTime).format('HH:mm')

Template.orders.events
  'click a.confirm': ->
    Meteor.call 'confirm', @_id