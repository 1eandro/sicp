require 'rubygems'
require 'bundler/setup'

require 'httparty'
require 'nokogiri'
require 'csv'

URL = 'http://community.schemewiki.org/?SICP-Solutions'

Chapter = Struct.new(:id, :title)
Section = Struct.new(:id, :chap_id, :no,:title)
Exercise = Struct.new(:id, :chap_id, :section_id, :no)


########################
# get html and normalize
########################

def get_html(url = URL)
  return HTTParty.get(url)
end

def seperate(html, tag, seperator)
  tag = '<' + tag
  start_tag = "<#{seperator}>"
  end_tag = "</#{seperator}>"
  sub_string = end_tag + start_tag + tag

  return html.gsub(tag, sub_string) # Add seperators
             .sub(end_tag, '')      # Remove the first instance of the end tag
end

def seperate_chapters(html)
  return seperate(html, 'h3', 'chapter')
end

def seperate_sections(html)
  chs = html.split(/(<\/chapter>)/) # Split into chapters
  chs.map! { |ch| seperate(ch, 'h4', 'section')} # Seperate each section in the chapter

  chs.map! do |ch|              # Close last <section>
    if ch != '</chapter>'
      ch + '</section>'
    else
      ch
    end
  end

  return chs.join
end

def fix_exercise(html)
  replacement = '<li><a href="/?sicp-ex-1.14">sicp-ex-2.14</a
>
</li
><li><a href="/?sicp-ex-1.15">sicp-ex-2.15</a
>
</li
><li><a href="/?sicp-ex-1.16">sicp-ex-2.16</a
>
</li
>'

  to_replace = '<li><a href="/?sicp-ex-2.14-2.15-2.16">sicp-ex-2.14-2.15-2.16</a
>
</li
>'

  return html.sub(to_replace, replacement)
end

def normalize(html)
  fix_exercise(seperate_sections(seperate_chapters(html)))
end

#############################
# scrape from normalized html
#############################

def get_content(node)
  return node.content.delete "\n"
end

def get_chapter(node)
  chapter = get_content node
  id = chapter[/\d/].to_i
  title = chapter.split(". ").last
  return Chapter.new(id, title)
end

def get_chapters(html)
  html.xpath('//chapter//h3').map {|c| get_chapter c}
end

def get_section(node)
  section = get_content node
  ids = section.scan(/\d/)
  no = ids.last.to_i
  chap_id = ids.first.to_i
  id = chap_id * 10 + no
  title = section.split(/\.\d /).last
  return Section.new(id, chap_id, no, title)
end

def get_sections(html)
  html.xpath('//section//h4').map { |t| get_section t }
end

def get_exercise(node)
  exercise = get_content node
  nos = exercise.scan(/\d{1,2}/)
  
  chap_id = nos.first.to_i
  no = nos.last.to_i

  section = node.parent.parent.parent
  section_id = (chap_id * 10) + section.xpath("preceding-sibling::*").size

  id = chap_id * 100 + no

  return Exercise.new(id, chap_id, section_id, no)
end

def get_exercises(html)
  html.xpath('//ul//li//a').map{ |n| get_exercise n}
end

#############
# write data
#############

def write(data, struct, file)
  csv = CSV.generate(write_headers: true, headers: struct.members) do |csv|
    data.each { |elem| csv << elem }
  end

  File.open(file, "w") { |f| f.write csv }
end

###############
# "main"
###############
doc = Nokogiri.XML(normalize(get_html))

chapters = get_chapters(doc)
sections = get_sections(doc)
exercises = get_exercises(doc)

write(chapters, Chapter, 'data/book/chapters.csv')
write(sections, Section, 'data/book/sections.csv')
write(exercises, Exercise, 'data/book/exercises.csv')
