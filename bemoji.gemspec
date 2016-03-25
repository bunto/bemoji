Gem::Specification.new do |s|
  s.name        = 'bemoji'
  s.summary     = 'GitHub-flavored emoji plugin for Bunto'
  s.version     = '3.0.0'
  s.authors     = ['GitHub, Inc.']
  s.email       = 'support@github.com'

  s.homepage = 'https://github.com/bunto/bemoji'
  s.licenses = ['MIT']
  s.files    = [ 'lib/bemoji.rb' ]

  s.add_dependency 'bunto'
  s.add_dependency 'html-pipeline', '~> 2.2'
  s.add_dependency 'gemoji', '~> 2.0'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rdoc'
  s.add_development_dependency 'rspec', '~> 3.0'
end
