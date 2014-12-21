Template.orders.helpers
  orders: ->
    Orders.find()

  isMyPlace: ->
    @placeName is Meteor.user().myPlace

  isMyOrder: ->
    @userId is Meteor.userId()

  isoDate: ->
    @date.toISOString()
