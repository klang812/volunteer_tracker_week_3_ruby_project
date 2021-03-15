require 'rspec'
require 'project'
require 'volunteer'
require 'spec_helper'

describe '#Volunteer' do

  describe '#name' do
    it 'returns the name of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.name).to eq 'Jane'
    end
  end

  describe '#project_id' do
    it 'returns the project_id of the volunteer' do
      test_volunteer = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(test_volunteer.project_id).to eq 1
    end
  end

  describe '#==' do
    it 'checks for equality based on the name of a volunteer' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer2 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer1 == volunteer2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Volunteer.all).to eq []
    end

    it 'returns all volunteers' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.all).to eq [volunteer1, volunteer2]
    end
  end

  describe '#save' do
    it 'adds a volunteer to the database' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      expect(Volunteer.all).to eq [volunteer1]
    end
  end

  describe '.find' do
    it 'returns a volunteer by id' do
      volunteer1 = Volunteer.new({:name => 'Jane', :project_id => 1, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 1, :id => nil})
      volunteer2.save
      expect(Volunteer.find(volunteer1.id)).to eq volunteer1
    end
  end

  describe('.find_volunteers_by_project_id') do
    it("finds volunteers that are working on a project") do
      project = Project.new({:title => 'Teaching Kids to Code'})
      project.save
      volunteer = Volunteer.new({:name => 'Jane', :project_id => project.id, :id => nil})
      volunteer.save()
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => 2, :id => nil})
      volunteer2.save()
      expect(Volunteer.find_volunteers_by_project_id(project.id)).to(eq([volunteer]))
    end
  end

  describe('#update') do
    it 'allows a user to update a volunteer name' do
      volunteer = Volunteer.new({:name => 'Jasmine', :project_id => 1, :id => nil})
      volunteer.save
      volunteer.update({:name => 'Jane', :project_id => 1, :id => nil})
      expect(volunteer.name).to(eq('Jane'))
    end
  end

  context '#delete' do
    it 'allows a user to delete a volunteer' do
      volunteer = Volunteer.new({:name => 'Jasmine', :project_id => 1, :id => nil})
      volunteer.save
      volunteer.delete
      expect(Volunteer.all).to eq []
    end
  end
end

