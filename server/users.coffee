Accounts.onCreateUser (options, user) ->
  user.profile = options.profile  if options.profile

  if user.services.twitter
    user.profile.avatar = user.services.twitter.profile_image_url_https
  else if user.services.facebook
    user.profile.avatar = "http://graph.facebook.com/#{user.services.facebook.id}/picture"
  else if user.services.google
    userinfo = Meteor.http.get("https://www.googleapis.com/oauth2/v2/userinfo",
      params:
        access_token: user.services.google.accessToken
    )
    throw userinfo.error if userinfo.error
    user.profile.avatar = userinfo.data.picture

  user
