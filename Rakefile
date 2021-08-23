task :default => :build

desc 'build site'
task :build => ['data:scrape_book'] do
  sh 'hugo'
end

task :not_dirty do
  fail "Directory not clean" if /nothing to commit/ !~ `git status`
end

desc "Deploy to Github Pages"
task :deploy => [:not_dirty, :build] do
  sh 'git checkout master'
  head = `git log --pretty="%h" -n1`.strip
  sh 'git checkout gh-pages'
  cp_r FileList['public/*'], '.'
  sh 'git add .'
  sh "git commit -m 'Updated website to #{head}'"
  sh 'push git'
  sh 'git checkout master'
end

desc "Create a new exercise"
task :new_ex, [:ex] do |t, args|
  require './lib/new_exercise'

  if args[:ex]
    NewExercise.new_exercise_from_id args[:ex]
  else
    NewExercise.new_exercise
  end
end
