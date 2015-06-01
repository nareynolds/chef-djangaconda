#
# Cookbook Name:: djangaconda
# Recipe:: default
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#



# install Anaconda
include_recipe 'anaconda::default'

# set Anaconda environement for all users
include_recipe 'anaconda::shell_conveniences'

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
#conda_owner_home = node.anaconda.home

# get project attributes
project_dir = node.djangaconda.project_directory
project_name = node.djangaconda.project_name
gitrepo_name = node.djangaconda.project_gitrepo_name
gitrepo_source = node.djangaconda.project_gitrepo_source
gitrepo_branch = node.djangaconda.project_gitrepo_branch

# how to install project
install_method = node.djangaconda.project_install_method

case install_method

  when 'create-new'

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


# migrate project
# execute 'migrate_django_project' do
#   user xuser
#   group xgroup
#   cwd project_dir
#   environment ({
#   	'HOME' => home_dir,
#   	'USER' => xuser,
#   	'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}"
#   	})
#   command "python manage.py migrate"
# end

