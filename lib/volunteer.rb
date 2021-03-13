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

end