# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{donald}
  s.version = "0.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Bruno Grasselli"]
  s.date = %q{2010-04-21}
  s.default_executable = %q{donald}
  s.description = %q{Use this gem when a git conflict happens and it will open all conflicted files using vim (one file by tab).}
  s.email = %q{bruno.grasselli@gmail.com}
  s.executables = ["donald"]
  s.files = ["README.textile", "LICENSE", "bin/donald", "lib/donald/merge_tool.rb"]
  s.homepage = %q{http://brunograsselli.com.br}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Simple vim based mergetool for git users.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
