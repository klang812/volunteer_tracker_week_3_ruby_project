class Project
attr_reader :id
attr_accessor :title

  def initialize(attributes)
    @title = attributes[:title]
    @id = attributes[:id]
  end

  def title
    DB.exec("SELECT * FROM projects WHERE title = #{@title};").first()
  end


end
