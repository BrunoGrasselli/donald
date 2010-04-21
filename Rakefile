require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

GEM = 'donald'
AUTHOR = 'Bruno Grasselli'
EMAIL = 'bruno.grasselli@gmail.com'
HOMEPAGE = 'http://brunograsselli.com.br'
DATE = "#{Time.now.year}-#{Time.now.month}-#{Time.now.day}"
GEM_VERSION = '0.1.3'
SUMMARY = 'Simple vim based mergetool for git users.'
DESCRIPTION = 'Use this gem when a git conflict happens and it will open all conflicted files using vim (one file by tab).'

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.date = DATE
  s.author = AUTHOR
  s.email = EMAIL
  s.summary = SUMMARY
  s.homepage = HOMEPAGE
  s.description = DESCRIPTION
  s.default_executable = %q{donald}
  s.executables = ["donald"]
  s.files = [
    "README.textile",
    "LICENSE",
    "bin/donald",
    "lib/donald/merge_tool.rb"
    ]
end

Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fp --color)
end

desc "Create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
