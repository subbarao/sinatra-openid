# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sinatra-openid}
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.description = %q{}
  s.authors = ["SubbaRao Pasupuleti"]
  s.date = %q{2009-07-20}
  s.email = %q{subbarao.pasupuleti@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".gitignore",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "lib/sinatra/openid.rb",
    "views/login.haml",
    "public/js/open-selector-0.3.js",
    "public/js/jquery-1.2.6.min.js",
    "test/test_helper.rb",
    "test/sinatra-openid_test.rb",
  ]
  s.homepage = %q{http://github.com/subbarao/sinatra-openid}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{WELCOME}
  s.test_files = [
    "test/openid_test.rb",
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 2.0.4"])
      s.add_runtime_dependency(%q<rack-openid>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 2.0.4"])
      s.add_dependency(%q<rack-openid>, [">= 0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
    s.add_dependency(%q<haml>, [">= 2.0.4"])
    s.add_dependency(%q<rack-openid>, [">= 0"])
  end
end
