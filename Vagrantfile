# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.hostname = 'djangaconda-berkshelf'

  # Set the version of chef to install using the vagrant-omnibus plugin
  # NOTE: You will need to install the vagrant-omnibus plugin:
  #
  #   $ vagrant plugin install vagrant-omnibus
  #
  if Vagrant.has_plugin?("vagrant-omnibus")
    config.omnibus.chef_version = :latest
  end

  # Every Vagrant virtual environment requires a box to build off of.
  # If this value is a shorthand to a box in Vagrant Cloud then
  # config.vm.box_url doesn't need to be specified.
  config.vm.box = "ubuntu/trusty64" # Ubuntu Server Trusty 14.04

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.network "forwarded_port", guest: 8000, host: 8001 # django dev default port

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # The path to the Berksfile to use with Vagrant Berkshelf
  config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # Use chef to provision this machine
  config.vm.provision "chef_solo" do |chef|

    # Cookbooks directory path relative to this file
    # chef.cookbooks_path = "cookbooks"

    # Example: specify cookbook attributes
    # to use defaults to install several python packages and 
    # create a blank project running on SQLite and the django dev server
    # chef.json = {
    #   :djangaconda => {
    #     :conda_version => 'miniconda-python3',
    #     :conda_flavor => 'x86_64', # should match VM choice above
    #     :conda_packages => [
    #       { :name => 'astroid' },
    #       { :name => 'rpy2', :channel => 'https://conda.binstar.org/r'},
    #     ],
    #     :project_name => 'my_great_project',
    #   },
    # }

    # specify cookbook attributes
    # to git clone Polls Tutorial project and run it on PostresSQL, Nginx, Gunicorn
    chef.json = {
      :djangaconda => {
        :owner => 'vagrant',
        :group => 'vagrant',
        :conda_version => 'miniconda-python3',
        :conda_flavor => 'x86_64', # should match VM choice above
        :project_name => 'polls_tutorial',
        :project_install_method => 'git-clone',
        :project_gitrepo_name => 'django-polls-tutorial',
        :project_gitrepo_source => 'git://github.com/nareynolds/django-polls-tutorial.git',
        :project_gitrepo_branch => 'master',
        :database_type => 'postgresql',
        :postgresql_password => 'somebigstrongpassword',
        :database_name => 'db', # should match settings.py
        :database_user => 'pollster', # should match settings.py
        :database_password => 'anotherbigstrongpassword', # should match settings.py
        :database_migrate => true,
        :database_loaddata => true,
        :database_fixture => 'project_data.json',
        :server_type => 'nginx-gunicorn',
        :collect_static_files => true,
        :server_start => true,
      },
    }

    # specify the chef run list
    chef.run_list = [
      'recipe[djangaconda::default]',
    ]

  end

end
