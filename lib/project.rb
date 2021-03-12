class Project
attr_reader :id
attr_accessor :title

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def title
    DB.exec("SELECT title FROM projects WHERE title = '#{@title}';").first()["title"]
  end

  def self.all
    all_titles = DB.exec("SELECT * FROM projects;")
    titles = []
    all_titles.each do |new_title|
      id = new_title["id"]
      title = new_title["title"]
      titles.push(Project.new({:title => title, :id => nil}))
    end
    titles
  end

  def id
    DB.exec("SELECT id FROM projects WHERE id = #{@id};").first()["id"]
  end

end
