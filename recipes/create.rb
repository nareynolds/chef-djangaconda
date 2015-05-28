#
# Cookbook Name:: djangaconda
# Recipe:: create
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'anaconda::default'

# get anaconda attributes
conda_version = node.anaconda.version
conda_install_dir = "#{node.anaconda.install_root}/#{conda_version}"
conda_bin_dir = "#{conda_install_dir}/bin"
xuser = node.anaconda.owner
xgroup = node.anaconda.group
home_dir = node.anaconda.home

# get project attributes
project_name = node.djangaconda.project_name
project_dir = "#{home_dir}/#{project_name}"

# create project
execute "django_create_#{project_name}" do
  command "django-admin.py startproject #{project_name}"
  action :run
  user xuser
  group xgroup
  cwd home_dir
  environment ({
  	'HOME' => home_dir,
  	'USER' => xuser,
  	'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}"
  	})
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

# run server
# execute 'run_django_project' do
#   user xuser
#   group xgroup
#   cwd "#{home_dir}/#{project_name}"
#   environment ({
#   	'HOME' => home_dir,
#   	'USER' => xuser,
#   	'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}"
#   	})
#   command "python manage.py runserver [::]:8000"
# end

