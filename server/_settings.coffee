# Provide defaults for Meteor.settings
#
# To configure your own Twitter keys, see:
#   https://github.com/meteor/meteor/wiki/Configuring-Twitter-in-Local-Market
Meteor.settings = {}  if typeof Meteor.settings is "undefined"
_.defaults Meteor.settings,
  twitter:
    consumerKey: "NBNynD1eGeyF9Bfe3R5OfVM9S"
    secret: "ZHsDoyXksyxy5KqGQ1nzpQ0K61ENmq22BbQaFex7G2gPnlaqGe"
  facebook:
    appId: "773374359383993"
    secret: "b6dbea8499871f198ea5d42e6400aa74"

ServiceConfiguration.configurations.remove service: "twitter"
ServiceConfiguration.configurations.insert
  service: "twitter"
  consumerKey: Meteor.settings.twitter.consumerKey
  secret: Meteor.settings.twitter.secret

ServiceConfiguration.configurations.remove service: "facebook"
ServiceConfiguration.configurations.insert
  service: "facebook"
  appId: Meteor.settings.facebook.appId
  secret: Meteor.settings.facebook.secret
