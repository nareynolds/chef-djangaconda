#
# Cookbook Name:: djangaconda
# Recipe:: django
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


include_recipe 'djangaconda::anaconda'

# install django into Anaconda
anaconda_package 'django' do
  action :install
end

# install any other desired packages...
# for example, install rpy2 into Anaconda
# anaconda_package 'rpy2' do
#   action :install
#   channel "https://conda.binstar.org/r"
# end


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


# how to install project
install_method = node.djangaconda.project_install_method

# migrate project after install?
migrate_project = node.djangaconda.project_migrate


# how to install project?
case install_method

  when 'create-new'

    # set project root
    project_root = "#{project_dir}/#{project_name}"

  	# create a new project
    execute "django_create_#{project_name}" do
      command "django-admin.py startproject #{project_name}"
      action :run
      group conda_group
      user conda_owner
      cwd project_dir
      environment({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
    end

  when 'git-clone'
    
    # set project root
    project_root = "#{project_dir}/#{gitrepo_name}"

    # install git
    include_recipe 'git::default'

    # git clone project
    git "#{project_dir}/#{gitrepo_name}" do
      repository gitrepo_source
      revision gitrepo_branch
      group conda_group
      user conda_owner
      action :sync
    end

  else
    # do nothing...
end

# migrate project?
if migrate_project
  execute 'migrate_django_project' do
    command "python manage.py migrate"
    action :run
    group conda_group
    user conda_owner
    cwd project_root
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end
end
