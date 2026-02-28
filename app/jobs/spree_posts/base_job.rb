module SpreePosts
  class BaseJob < Spree::BaseJob
    queue_as SpreePosts.queue
  end
end
