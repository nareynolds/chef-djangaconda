#
# Cookbook Name:: djangaconda
# Recipe:: default
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#



# anaconda setup
include_recipe 'djangaconda::anaconda'

# django setup
include_recipe 'djangaconda::django'

# database setup
include_recipe 'djangaconda::database'

# server setup
include_recipe 'djangaconda::server'
