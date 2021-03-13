class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id
  
  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  # def name
  #   DB.exec("SELECT name FROM volunteers WHERE name = '#{@name}';").first()["name"]
  # end

end