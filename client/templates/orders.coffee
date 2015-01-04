Template.orders.helpers
  orders: ->
    Orders.find({}, {sort: {served: 1, arrivalTime: 1}})

  isServed: ->
    @served and "is-served"

  isMyPlace: ->
    @placeName is Meteor.user().myPlace

  isMyOrder: ->
    @userId is Meteor.userId()

  isoDate: ->
    @arrivalTime.toISOString()

  time: ->
    moment(@arrivalTime).format('HH:mm')

Template.orders.events
  'click a.confirm': ->
    Meteor.call 'confirm', @_id

  'click a.serve': ->
    Meteor.call 'serve', @_id
