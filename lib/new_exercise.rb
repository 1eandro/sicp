require 'csv'
require 'erb'

EX_DIR = 'content/exercises/'
CSV_FILE = 'data/book/exercises.csv'
TEMPLATE = 'rake_templates/exercises/index.md.erb'

module NewExercise
  def self.get_last_exercise
    puts Dir.pwd
    last_ex = Dir.glob([EX_DIR + '*']).last
    ids = last_ex.scan(/\d{1,2}/)
    id = ids.join ''
    return id
  end

  def self.get_exercise_from_id(id, offset = 1)
    file = File.read(CSV_FILE).split(/^#{Regexp.quote id.to_s}/)
    row_num = file.first.count("\n") - offset
    csv = CSV.table(CSV_FILE)
    return csv[row_num], row_num + 1
  end

  def self.get_new_exercise(id)
    get_exercise_from_id id, 0
  end

  def self.get_nth(lineno)
    case lineno.to_s[-1]
    when 1
      "st"
    when 2
      "nd"
    when 3
      "rd"
    else
      "th"
    end
  end

  def self.create_exercise(val)
    ex = val.first
    lineno = val.last

    chap = ex[:chap_id]
    nth = get_nth(lineno)

    if ex[:no].to_s.length == 1
      no = '0' + ex[:no].to_s
    else
      no = ex[:no]
    end

    id = ex[:id]
    weight = id

    dir_name = "sicp-ex-#{chap}-#{no}"
    template = ERB.new(File.read(TEMPLATE), 0, "%<>")


    dir = "#{EX_DIR}#{dir_name}"
    file = "#{dir}/index.md"
    unless File.exists? file
      Dir.mkdir(dir)
      File.write(file, template.result(binding))
      puts "Created #{file}"
    else
      raise StandardError.new "#{file} already exists"
    end
  end

  def self.new_exercise
    create_exercise get_new_exercise get_last_exercise
  end

  def self.new_exercise_from_id(id)
    create_exercise get_exercise_from_id id
  end
end
