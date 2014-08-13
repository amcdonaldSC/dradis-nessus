require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require "bundler/gem_tasks"

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the nessus_upload_import plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the nessus_upload_import plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'NessusUploadImport'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
