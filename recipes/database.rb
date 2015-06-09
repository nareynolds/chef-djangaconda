#
# Cookbook Name:: djangaconda
# Recipe:: database
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# require django+project setup
include_recipe 'djangaconda::django'

# anaconda settings
conda_owner = node.djangaconda.owner
conda_group = node.djangaconda.group
conda_bin_dir = node.djangaconda.conda_bin_dir

# project settings
project_parent_dir = node.djangaconda.project_parent_directory

# general database settings
database_type = node.djangaconda.database_type
database_name = node.djangaconda.database_name
database_user = node.djangaconda.database_user
database_password = node.djangaconda.database_password
database_migrate = node.djangaconda.database_migrate
database_loaddata = node.djangaconda.database_loaddata
database_fixture = node.djangaconda.database_fixture

# PostgreSQL settings
postgresql_host = node.djangaconda.postgresql_host
postgresql_port = node.djangaconda.postgresql_port
postgresql_listen_addresses = node.djangaconda.postgresql_listen_addresses
postgresql_password = node.djangaconda.postgresql_password


# select database type
case database_type

  when 'sqlite'
    # just make sure the django project's
    #  setting.py is set appropriately
    #  Django will handle the rest for you.

  when 'postgresql'

    # set PostgresSQL attributes
    node.default.postgresql.password.postgres = postgresql_password
    node.default.postgresql.config.port = postgresql_port
    node.default.postgresql.config.listen_addresses = postgresql_listen_addresses
    # set host?
    
    # install PostgresSQL database
    include_recipe 'postgresql::server'

    # install chef database abstraction layer
    include_recipe "database::postgresql"

    # install psycopg2 PostgreSQL adaptor into Anaconda
    anaconda_package 'psycopg2' do
      action :install
    end

    # define postgresql connection info
    postgresql_connection_info = {
      :host     => postgresql_host,
      :port     => node['postgresql']['config']['port'],
      :username => 'postgres',
      :password => node['postgresql']['password']['postgres']
    }

    # create a postgresql database
    postgresql_database database_name do
      connection postgresql_connection_info
      action :create
    end

    # create a postgresql user
    postgresql_database_user database_user do
      connection postgresql_connection_info
      password database_password
      action :create
    end

    # grant all privileges on all tables in db to this user
    postgresql_database_user database_user do
      connection postgresql_connection_info
      database_name database_name
      privileges [:all]
      action :grant
    end

  else
    # do nothing...

end


# migrate django project to database?
if database_migrate

  # makemigrations
  execute 'makemigrations_django_project' do
    command "python manage.py makemigrations"
    action :run
    group conda_group
    user conda_owner
    cwd project_parent_dir
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end

  # migrate
  execute 'migrate_django_project' do
    command "python manage.py migrate"
    action :run
    group conda_group
    user conda_owner
    cwd project_parent_dir
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end
  
end


# load database from fixture file?
if database_loaddata

  # loaddata
  execute 'loaddata_django_project' do
    command "python manage.py loaddata #{database_fixture}"
    action :run
    group conda_group
    user conda_owner
    cwd project_parent_dir
    environment ({ 'PATH' => "#{conda_bin_dir}:#{ENV["PATH"]}" })
  end

end

