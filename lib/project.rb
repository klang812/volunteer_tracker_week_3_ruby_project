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
      id = new_title["id"].to_i
      title = new_title["title"]
      titles.push(Project.new({:title => title, :id => id}))
    end
    titles
  end

  def ==(projects_to_compare)
    if projects_to_compare != nil
      self.id() == projects_to_compare.id()
    else
      false
    end
  end

  def save
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end


end
