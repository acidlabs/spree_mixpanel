# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_mixpanel'
  s.version     = '2.2.0'
  s.summary     = 'Spree/Mixpanel integration'
  s.description =  s.summary
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Marcos Teixeira'
  s.email     = 'm.viniteixeira@gmail.com'
  s.homepage  = 'https://github.com/marcosteixeira/spree_mixpanel'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '~> 2.2.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'mixpanel-ruby', '~> 1.4.0'

  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sqlite3'
end
