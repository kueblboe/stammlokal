# Provide defaults for Meteor.settings
#
# To configure your own Twitter keys, see:
#   https://github.com/meteor/meteor/wiki/Configuring-Twitter-in-Local-Market
Meteor.settings = {}  if typeof Meteor.settings is "undefined"
_.defaults Meteor.settings,
  twitter:
    consumerKey: "PLfrg2bUh0oL0asi3R2fumRjm"
    secret: "sRI8rnwO3sx7xUAxNWTX0WEDWph3WEBHu6tTdJYQ5wVrJeVCCt"

ServiceConfiguration.configurations.remove service: "twitter"
ServiceConfiguration.configurations.insert
  service: "twitter"
  consumerKey: Meteor.settings.twitter.consumerKey
  secret: Meteor.settings.twitter.secret

