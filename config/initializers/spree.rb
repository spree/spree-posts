Rails.application.config.after_initialize do
  # Dependencies
  Spree::Dependencies.posts_finder = 'Spree::Posts::Find'
  Spree::Dependencies.posts_sorter = 'Spree::Posts::Sort'

  if defined?(Spree::Api)
    Spree::Api::Dependencies.storefront_posts_finder = 'Spree::Posts::Find'
    Spree::Api::Dependencies.storefront_posts_sorter = 'Spree::Posts::Sort'
  end

  # Metafields
  Rails.application.config.spree.metafields.enabled_resources.push(Spree::Post, Spree::PostCategory)

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
