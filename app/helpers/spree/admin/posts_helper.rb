module Spree
  module Admin
    module PostsHelper
      def post_authors_select_options
        current_store.users.map { |user| [user.name, user.id] }
      end

      def post_tags_json_array
        Spree::Post.all_tags.map { |tag| { name: tag.name } }.to_json
      end
    end
  end
end
