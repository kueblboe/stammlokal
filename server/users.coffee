Accounts.onCreateUser (options, user) ->
  user.profile = options.profile  if options.profile
  
  # If this is the first user going into the database, make them an admin
  user.admin = true  if Meteor.users.find().count() is 0
  user

