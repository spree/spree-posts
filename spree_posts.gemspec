# encoding: UTF-8
lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_posts/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_posts'
  s.version     = SpreePosts::VERSION
  s.summary     = "Spree Commerce Posts Extension"
  s.required_ruby_version = '>= 3.2'

  s.author    = 'You'
  s.email     = 'you@example.com'
  s.homepage  = 'https://github.com/your-github-handle/spree_posts'
  s.license = 'MIT'

  s.files        = Dir["{app,config,db,lib,vendor}/**/*", "LICENSE.md", "Rakefile", "README.md"].reject { |f| f.match(/^spec/) && !f.match(/^spec\/fixtures/) }
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 5.4.0.beta'
  s.add_dependency 'spree', spree_version
  s.add_dependency 'spree_admin', spree_version

  s.add_development_dependency 'spree_dev_tools'
end
