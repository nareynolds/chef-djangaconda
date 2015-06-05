#
# Cookbook Name:: djangaconda
# Recipe:: migrate
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'djangaconda::django'
include_recipe 'djangaconda::database'


# get anaconda attributes
conda_version = node.anaconda.version
conda_install_dir = "#{node.anaconda.install_root}/#{conda_version}"
conda_bin_dir = "#{conda_install_dir}/bin"
conda_group = node.anaconda.group
conda_owner = node.anaconda.owner

# get project attributes
project_dir = node.djangaconda.project_directory
project_name = node.djangaconda.project_name
project_root = nil # set below
gitrepo_name = node.djangaconda.project_gitrepo_name
gitrepo_source = node.djangaconda.project_gitrepo_source
gitrepo_branch = node.djangaconda.project_gitrepo_branch


# migrate project after install?
migrate_project = node.djangaconda.project_migrate

if migrate_project

  # makemigrations
  execute 'migrate_django_project' do
    command "python manage.py makemigrations"
    action :run
    group conda_group
    user conda_owner
    cwd project_root
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end

  # migrate
  execute 'migrate_django_project' do
    command "python manage.py migrate"
    action :run
    group conda_group
    user conda_owner
    cwd project_root
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end
  
end
