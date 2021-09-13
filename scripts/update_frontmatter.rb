require 'rubygems'
require 'bundler/setup'

require 'psych'
require 'csv'

FRONTMATTER = [:title, :date, :weight, :id]
EXERCISES = "data/book/exercises.csv"

def update_file(file)
  re = /(?<=---\n)((.|\n)*)(?=---\n)/

  text = File.read file

  frontmatter = Psych.load(text.scan(re).first.first).transform_keys(&:to_sym).to_h
  new_frontmatter = Psych.dump sort_matter add_matter delete_useless_matter frontmatter

  new_frontmatter.sub!(/---\n/, '').gsub!( /^:/, '').gsub!(/'/, '')

  new_text = text.sub(re, new_frontmatter)

  File.write file, new_text
end

def delete_useless_matter(hash)
  (hash.keys - FRONTMATTER).each { |key| hash.delete key}
  hash
end

def sort_matter(hash)
  hash = hash.sort_by { |key, val| FRONTMATTER.find_index(key) }
  hash.to_h
end

def add_matter(hash)
  id = hash[:title].scan(/\d/).join('')
  weight = id

  hash.merge({id: id, weight: weight})
end

for file in Dir["content/exercises/*/index.md"]
  update_file file
end
