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

# install extra packages into the Anaconda environment
node.djangaconda.conda_packages.each do |pkg|
  anaconda_package pkg[:name] do
    action :install
    if defined? pkg[:env_name] then 
      env_name pkg[:env_name]
    end
    if defined? pkg[:env_path_prefix] then
      env_path_prefix pkg[:env_path_prefix]
    end
    if defined? pkg[:channel] then
    	channel pkg[:channel]
    end
    if defined? pkg[:override_channels] then
    	override_channels pkg[:override_channels]
    end
    if defined? pkg[:no_pin] then
    	no_pin pkg[:no_pin]
    end
    if defined? pkg[:force_install] then
    	force_install pkg[:force_install]
    end
    if defined? pkg[:revision] then
    	revision pkg[:revision]
    end
    if defined? pkg[:file] then
    	file pkg[:file]
    end
    if defined? pkg[:unknown] then
    	unknown pkg[:unknown]
    end
    if defined? pkg[:no_deps] then
    	no_deps pkg[:no_deps]
    end
    if defined? pkg[:mkdir] then
    	mkdir pkg[:mkdir]
    end
    if defined? pkg[:use_index_cache] then
    	use_index_cache pkg[:use_index_cache]
    end
    if defined? pkg[:use_local] then
    	use_local pkg[:use_local]
    end
    if defined? pkg[:alt_hint] then
    	alt_hint pkg[:alt_hint]
    end
  end
end

# for example, install rpy2 into Anaconda
# anaconda_package 'rpy2' do
#   action :install
#   channel "https://conda.binstar.org/r"
# end


