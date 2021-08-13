task :default => :build

desc 'build site'
task :build => ['data:scrape_book'] do
  sh 'hugo'
end
