class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id
  
  def initialize(attributes)
    @name = attributes[:name]
    @project_id = attributes[:project_id]
    @id = attributes[:id]
  end

  def ==(volunteers_to_compare)
    if volunteers_to_compare != nil
      self.id() == volunteers_to_compare.id()
    else
      false
    end
  end

  def self.all
    all_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    all_volunteers.each do |new_volunteer|
      id = new_volunteer["id"].to_i
      name = new_volunteer["name"]
      project_id = new_volunteer["project_id"]
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

end