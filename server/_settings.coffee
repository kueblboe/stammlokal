# Provide defaults for Meteor.settings
#
# To configure your own Twitter keys, see:
#   https://github.com/meteor/meteor/wiki/Configuring-Twitter-in-Local-Market
Meteor.settings = {}  if typeof Meteor.settings is "undefined"
_.defaults Meteor.settings,
  twitter:
    consumerKey: "NBNynD1eGeyF9Bfe3R5OfVM9S"
    secret: "ZHsDoyXksyxy5KqGQ1nzpQ0K61ENmq22BbQaFex7G2gPnlaqGe"

ServiceConfiguration.configurations.remove service: "twitter"
ServiceConfiguration.configurations.insert
  service: "twitter"
  consumerKey: Meteor.settings.twitter.consumerKey
  secret: Meteor.settings.twitter.secret

