#!/usr/bin/env ruby

namespace :data do
  directory 'data/book/'

  desc 'scrape info on exercises, sections and chapters'
  task :scrape_book => 'data/book/' do
    FILES = ['data/book/exercises.csv', 'data/book/sections.csv', 'data/book/chapters.csv']

    exist = FILES.map { |f| File.file? f}
    needed = exist.include? false

    if needed
      puts 'Scraping book'
      ruby 'scripts/scrape_book.rb'
    end
  end
end
