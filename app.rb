require('sinatra')
require('sinatra/reloader')
require('pry')
require('pg')
require('./lib/project')
require('./lib/volunteer')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})
# one project to MANY volunteers, (?)button to go list of projects
# homepage = list volunteers , <a> link to edit volunteer info, add volunteers
# project page = <a> to edit project
# project list page(?)

get('/') do
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

# get('/') do
#   @volunteers = Volunteer.all()
#   erb(:volunteers)
# end

# get('/volunteers') do
#   @volunteers = Volunteer.all()
#   erb(:volunteers)
# end

# get('/volunteers/new') do
#   erb(:)

# post('/volunteers') do




