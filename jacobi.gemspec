# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jacobi/version"

Gem::Specification.new do |s|
  s.name        = "jacobi"
  s.version     = Jacobi::VERSION
  s.authors     = ["Tim Martin"]
  s.email       = ["teimu.tm@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{jacobi is an application the performs the iterative Jacobi linear solution method on a 5x5 matrix.}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "jacobi"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
