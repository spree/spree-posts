require 'spree'
require 'spree_posts/engine'
require 'spree_posts/version'
require 'spree_posts/configuration'

module SpreePosts
  mattr_accessor :queue

  def self.queue
    @@queue ||= Spree.queues.default
  end
end
