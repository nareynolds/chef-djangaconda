#
# Cookbook Name:: djangaconda
# Recipe:: database
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# 
include_recipe 'djangaconda::django'



# # migrate project?
# migrate_project = node.djangaconda.project_migrate

# if migrate_project

#   # makemigrations
#   execute 'migrate_django_project' do
#     command "python manage.py makemigrations"
#     action :run
#     group conda_group
#     user conda_owner
#     cwd project_parent_dir
#     environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
#   end

#   # migrate
#   execute 'migrate_django_project' do
#     command "python manage.py migrate"
#     action :run
#     group conda_group
#     user conda_owner
#     cwd project_parent_dir
#     environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
#   end
  
# end
