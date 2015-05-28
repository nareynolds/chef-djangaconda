#
# Cookbook Name:: djangaconda
# Recipe:: clone
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'anaconda::default'

# get project attributes
project_repository = node.djangaconda.git_repository
project_branch = node.djangaconda.git_branch
project_destination = node.djangaconda.git_destination

# clone project
git project_destination do
  repository project_repository
  revision project_branch
  action :sync
end
