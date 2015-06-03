# anaconda attributes
default.djangaconda.conda_version = 'miniconda-python3'
default.djangaconda.conda_flavor = 'x86_64' # should match VM
default.djangaconda.conda_accept_license = 'yes' # to accept license
default.djangaconda.conda_install_root = '/opt/anaconda'
default.djangaconda.conda_owner = 'vagrant'
default.djangaconda.conda_group = 'vagrant'

# how to install django project
default.djangaconda.project_install_method = nil #, 'create-new', 'git-clone', 

# project location and name
default.djangaconda.project_directory = "#{node.anaconda.home}"
default.djangaconda.project_name = 'my_project'

# git repository of project
default.djangaconda.project_gitrepo_name = "#{node.djangaconda.project_name}"
default.djangaconda.project_gitrepo_source = 'git://github.com/nareynolds/django-polls-tutorial.git'
default.djangaconda.project_gitrepo_branch = 'master'

# migrate project
default.djangaconda.project_migrate = false #, true

# server selection
default.djangaconda.server = 'development' #, 'nginx-gunicorn', 'apache-mod_wsgi'
