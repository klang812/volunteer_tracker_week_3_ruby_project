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

  def self.find(id)
    volunteer = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first()
    if volunteer != nil
      name = volunteer["name"]
      project_id = volunteer["project_id"]
      id = volunteer["id"].to_i
      Volunteer.new({:name => name, :project_id => project_id, :id => id})
    else
      nil
    end
  end

  def self.find_volunteers_by_project_id(project_id)
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{project_id};")
    new_volunteers = []
    volunteers.each do |volunteer| 
        name = volunteer["name"]
        project_id = volunteer["project_id"]
        id = volunteer["id"].to_i
        new_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
      end
    new_volunteers
  end

  def update(name)
    @name = name[:name]
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE id = #{@id};")
  end
end