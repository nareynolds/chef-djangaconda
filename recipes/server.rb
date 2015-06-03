#
# Cookbook Name:: djangaconda
# Recipe:: server
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# 
include_recipe 'djangaconda::django'


#if node.attribute?('python') and node['python'].has_key? 'version'
  #node.override['python']['major_version'] = 3.4
#end

# install apache
#include_recipe 'apache2::mod_wsgi'



# install nginx
package 'nginx' do
  action :install
end
#include_recipe 'nginx::default'


# install Gunicorn into Anaconda
anaconda_package 'gunicorn' do
  action :install
end

