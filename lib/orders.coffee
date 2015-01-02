@Orders = new Meteor.Collection("orders")

Meteor.methods
  order: (placeName, text, minutes) ->
    check @userId, String
    check placeName, String
    check text, String
    check minutes, Number
    Orders.insert
      userId: @userId
      placeName: placeName
      placeAvatar: "/img/places/320x350/#{placeName}.jpg"
      userName: Meteor.user().profile.name
      userAvatar: Meteor.user().profile.avatar
      text: text
      confirmed: false
      served: false
      date: moment().add(minutes, 'minutes').toDate()

  confirm: (orderId) ->
    check @userId, String
    check orderId, String
    Orders.update(orderId, { $set: {'confirmed': true} })

  serve: (orderId) ->
    check @userId, String
    check orderId, String
    Orders.update(orderId, { $set: {'served': true} })
