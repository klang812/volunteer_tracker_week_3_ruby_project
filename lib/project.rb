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

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first()
    if project != nil
      title = project["title"]
      id = project["id"].to_i
      Project.new({:title => title, :id => id})
    else
      nil
    end
  end

  def update(title)
    @title = title
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
    
  end
  
  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

end
