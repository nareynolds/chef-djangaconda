#
# Cookbook Name:: djangaconda
# Recipe:: server
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#

# install apache
include_recipe 'apache2::mod_wsgi'

