#
# Cookbook Name:: djangaconda
# Recipe:: anaconda
#
# Copyright 2015, nareynolds
#
# All rights reserved - Do Not Redistribute
#


# set anaconda attributes
node.default.anaconda.owner = node.djangaconda.owner
node.default.anaconda.group = node.djangaconda.group
node.default.anaconda.home = node.djangaconda.home
node.default.anaconda.version = node.djangaconda.conda_version
node.default.anaconda.flavor = node.djangaconda.conda_flavor
node.default.anaconda.accept_license = node.djangaconda.conda_accept_license
node.default.anaconda.install_root = node.djangaconda.conda_install_root

# install Anaconda
include_recipe 'anaconda::default'

# set Anaconda environement for all users
include_recipe 'anaconda::shell_conveniences'
