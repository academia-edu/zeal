# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "zeal/version"

Gem::Specification.new do |s|
  s.name        = "zeal"
  s.version     = Zeal::VERSION
  s.authors     = ["Ryan Fitzgerald"]
  s.email       = ["rfitz@academia.edu"]
  s.homepage    = ""
  s.summary     = %q{eager loading (but not too eager) for ActiveRecord collections}
  s.description = %q{Zeal allows you to eager-load associations on ActiveRecord objects that have already been loaded from the database.}

  s.rubyforge_project = "zeal"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
