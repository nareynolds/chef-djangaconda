#
# Cookbook Name:: djangaconda
# Recipe:: server
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# require django+project setup
include_recipe 'djangaconda::django'


# get project attributes
conda_owner = node.djangaconda.owner
conda_group = node.djangaconda.group
conda_bin_dir = node.djangaconda.conda_bin_dir
project_dir = node.djangaconda.project_parent_directory
project_name = node.djangaconda.project_name

# get server attributes
server_type = node.djangaconda.server_type
server_start = node.djangaconda.server_start
gunicorn_workers = node.djangaconda.gunicorn_workers
nginx_port = node.djangaconda.nginx_port
nginx_domain = node.djangaconda.nginx_domain
collect_static = node.djangaconda.collect_static_files


# select server type
case server_type

  when 'django-dev'

    # create django dev server upstart file
    template '/etc/init/django.conf' do
      source 'django-conf.erb'
      action :create
      #mode '0755'
      owner conda_owner
      group conda_group
      variables({
        :owner => conda_owner,
        :group => conda_group,
        :conda_bin_dir => conda_bin_dir,
        :project_dir => project_dir,
      })
    end

    # start server?
    if server_start

      # start django dev server
      execute "django-dev-server-start" do
        command "sudo service django start"
        action :run
        group conda_group
        user conda_owner
        cwd project_dir
        environment({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
      end

    end

  when 'nginx-gunicorn'

    # install nginx
    package 'nginx' do
      action :install
    end

    # install Gunicorn into Anaconda
    anaconda_package 'gunicorn' do
      action :install
    end

    # create gunicorn upstart file
    template '/etc/init/gunicorn.conf' do
      source 'gunicorn-conf.erb'
      action :create
      #mode '0755'
      owner conda_owner
      group conda_group
      variables({
        :owner => conda_owner,
        :project_dir => project_dir,
        :project_name => project_name,
        :gunicorn_bin_dir => conda_bin_dir,
        :num_workers => gunicorn_workers,
      })
    end

    # delete default nginx config file
    file '/etc/nginx/sites-available/default' do
      action :delete
      backup false
    end

    # and delete the link that enables it
    link '/etc/nginx/sites-enabled/default' do
      action :delete
    end

    # create new nginx config file
    template "/etc/nginx/sites-available/#{project_name}" do
      source 'nginx-conf.erb'
      action :create
      #mode '0755'
      owner conda_owner
      group conda_group
      variables({
        :project_dir => project_dir,
        :project_name => project_name,
        :nginx_port => nginx_port,
        :nginx_domain => nginx_domain,
      })
    end

    # and create a link to enable it
    link "/etc/nginx/sites-enabled/#{project_name}" do
      to "/etc/nginx/sites-available/#{project_name}"
      action :create
    end

    # start server?
    if server_start

      # start gunicorn
      execute "gunicorn-restart" do
        command "sudo service gunicorn restart"
        action :run
        group conda_group
        user conda_owner
        cwd project_dir
        environment({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
      end

      # start nginx
      execute "nginx-restart" do
        command "sudo service nginx restart"
        action :run
        group conda_group
        user conda_owner
        cwd project_dir
        environment({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
      end

    end

  when 'apache-mod_wsgi'
    # can't get this to work...
  else
    # do nothing...

end #case server_type


# collect django's static files for nginx to serve?
if collect_static

  # collectstatic
  execute 'migrate_django_project' do
    command "python manage.py collectstatic --noinput"
    action :run
    group conda_group
    user conda_owner
    cwd project_dir
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end

end

# Commands to stop the server:
# sudo service django start
# sudo service gunicorn restart
# sudo service nginx restart
