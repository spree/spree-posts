pin 'application-spree-posts', to: 'spree_posts/application.js', preload: false

pin_all_from SpreePosts::Engine.root.join('app/javascript/spree_posts/controllers'),
             under: 'spree_posts/controllers',
             to:    'spree_posts/controllers',
             preload: 'application-spree-posts'
