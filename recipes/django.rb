#
# Cookbook Name:: djangaconda
# Recipe:: django
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# require anaconda installation
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


# anaconda settings
conda_owner = node.djangaconda.owner
conda_group = node.djangaconda.group
conda_bin_dir = node.djangaconda.conda_bin_dir

# project settings
project_root = node.djangaconda.project_install_root
project_name = node.djangaconda.project_name
project_parent_dir = nil # set below

# project install settings
install_method = node.djangaconda.project_install_method
gitrepo_name = node.djangaconda.project_gitrepo_name
gitrepo_source = node.djangaconda.project_gitrepo_source
gitrepo_branch = node.djangaconda.project_gitrepo_branch


# select project install method
case install_method

  when 'create-new'

    # set project root
    project_parent_dir = "#{project_root}/#{project_name}"

  	# create a new project
    execute "django_create_#{project_name}" do
      command "django-admin.py startproject #{project_name}"
      action :run
      group conda_group
      user conda_owner
      cwd project_root
      environment({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
    end

  when 'git-clone'
    
    # set project root
    project_parent_dir = "#{project_root}/#{gitrepo_name}"

    # install git
    include_recipe 'git::default'

    # git clone project
    git "#{project_root}/#{gitrepo_name}" do
      repository gitrepo_source
      revision gitrepo_branch
      group conda_group
      user conda_owner
      action :sync
    end

  else
    # do nothing...
end

# save project parent directory
node.default.djangaconda.project_parent_directory = project_parent_dir
