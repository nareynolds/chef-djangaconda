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

# install any other packages...

# install rpy2 into Anaconda
# anaconda_package 'rpy2' do
#   action :install
#   channel "https://conda.binstar.org/r"
# end
