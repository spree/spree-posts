Rails.application.config.after_initialize do
  # Store associations
  Spree::Store.class_eval do
    has_many :posts, class_name: 'Spree::Post', dependent: :destroy, inverse_of: :store
    has_many :post_categories, class_name: 'Spree::PostCategory', dependent: :destroy, inverse_of: :store

    after_create :ensure_default_post_categories_are_created

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

  # Admin navigation
  if defined?(Spree::Admin)
    sidebar_nav = Spree.admin.navigation.sidebar

    sidebar_nav.add :posts,
            label: :posts,
            url: :admin_posts_path,
            icon: 'article',
            position: 70,
            active: -> { %w[posts post_categories].include?(controller_name) },
            if: -> { can?(:manage, Spree::Post) }

    # Admin tables
    Spree.admin.tables.register(:posts, model_class: Spree::Post, search_param: :title_cont)

    Spree.admin.tables.posts.add :title,
                                       label: :title,
                                       type: :link,
                                       sortable: true,
                                       filterable: true,
                                       default: true,
                                       position: 10

    Spree.admin.tables.posts.add :post_category,
                                       label: :category,
                                       type: :string,
                                       filter_type: :autocomplete,
                                       sortable: false,
                                       filterable: true,
                                       default: true,
                                       position: 20,
                                       method: ->(post) { post.post_category_title },
                                       ransack_attribute: 'post_category_id',
                                       search_url: ->(view_context) { view_context.spree.select_options_admin_post_categories_path(format: :json) }

    Spree.admin.tables.posts.add :author,
                                       label: :author,
                                       type: :string,
                                       filter_type: :autocomplete,
                                       sortable: false,
                                       filterable: true,
                                       default: true,
                                       position: 30,
                                       method: ->(post) { post.author_name },
                                       ransack_attribute: 'author_id',
                                       search_url: ->(view_context) { view_context.spree.select_options_admin_admin_users_path(format: :json) }

    Spree.admin.tables.posts.add :published_at,
                                       label: :published_at,
                                       type: :date,
                                       sortable: true,
                                       filterable: true,
                                       default: true,
                                       position: 40

    Spree.admin.tables.posts.add :created_at,
                                       label: :created_at,
                                       type: :datetime,
                                       sortable: true,
                                       filterable: true,
                                       default: false,
                                       position: 50

    Spree.admin.tables.posts.add :updated_at,
                                       label: :updated_at,
                                       type: :datetime,
                                       sortable: true,
                                       filterable: true,
                                       default: false,
                                       position: 60

    # Post Categories Table
    Spree.admin.tables.register(:post_categories, model_class: Spree::PostCategory, search_param: :title_cont)

    Spree.admin.tables.post_categories.add :title,
                                                 label: :title,
                                                 type: :link,
                                                 sortable: true,
                                                 filterable: true,
                                                 default: true,
                                                 position: 10

    Spree.admin.tables.post_categories.add :posts_count,
                                                 label: :posts,
                                                 type: :number,
                                                 sortable: false,
                                                 filterable: false,
                                                 default: true,
                                                 position: 20,
                                                 method: ->(post_category) { post_category.posts.count }

    Spree.admin.tables.post_categories.add :created_at,
                                                 label: :created_at,
                                                 type: :datetime,
                                                 sortable: true,
                                                 filterable: true,
                                                 default: false,
                                                 position: 30

    Spree.admin.tables.post_categories.add :updated_at,
                                                 label: :updated_at,
                                                 type: :datetime,
                                                 sortable: true,
                                                 filterable: true,
                                                 default: false,
                                                 position: 40
  end
end
