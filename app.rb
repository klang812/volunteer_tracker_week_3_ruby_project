require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/project')
require('./lib/volunteer')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})


get('/') do
  @projects = Project.all()
  erb(:projects)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

post('/projects') do
  title = params[:title]
  project = Project.new({:title => title, :id => nil})
  project.save()
  @projects = Project.all()
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteers = Volunteer.find_volunteers_by_project_id(@project.id)
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update({:title => params[:title]})
  @projects = Project.all()
  erb(:projects)
end

delete('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  @projects = Project.all()
  erb(:projects)
end

get('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:edit_volunteer)
end

get('/volunteers') do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

patch('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @project = Project.find(@volunteer.project_id.to_i())
  @volunteer.update({:name => params[:name]})
  @volunteers = Volunteer.all()
  erb(:project)
end

post('/projects/:id/volunteers') do
  @volunteer = Volunteer.new({:name => params[:name], :project_id => params[:id]})
  @volunteer.save()
  @volunteers = Volunteer.all()
  @projects = Project.all()
  erb(:projects)
end

delete('/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.delete()
  @projects = Project.all()
  erb(:projects)
end




