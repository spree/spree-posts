module Spree
  module StoreDecorator
    def self.prepended(base)
      base.has_many :posts, class_name: 'Spree::Post', dependent: :destroy, inverse_of: :store
      base.has_many :post_categories, class_name: 'Spree::PostCategory', dependent: :destroy, inverse_of: :store

      base.after_create :ensure_default_post_categories_are_created
    end

    private

    def ensure_default_post_categories_are_created
      Spree::Events.disable do
        [
          I18n.t('spree.default_post_categories.resources', default: 'Resources'),
          I18n.t('spree.default_post_categories.articles', default: 'Articles'),
          I18n.t('spree.default_post_categories.news', default: 'News')
        ].each do |category_title|
          next if post_categories.where(title: category_title).exists?

          post_categories.create(title: category_title)
        end
      end
    end
  end
end

Spree::Store.prepend(Spree::StoreDecorator)
