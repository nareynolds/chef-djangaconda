#
# Cookbook Name:: djangaconda
# Recipe:: clone
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#

# install git
include_recipe 'git::default'

# get anaconda attributes
xuser = node.anaconda.owner
xgroup = node.anaconda.group

# get project attributes
project_name = node.djangaconda.clone_repo_name
project_repository = node.djangaconda.clone_repo_source
project_branch = node.djangaconda.clone_repo_branch
project_destination = node.djangaconda.clone_repo_destination

# clone project
git "#{project_destination}/#{project_name}" do
  repository project_repository
  revision project_branch
  user xuser
  group xgroup
  action :sync
end
