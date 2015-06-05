# user attributes
default.djangaconda.owner = 'vagrant'
default.djangaconda.group = 'vagrant'
default.djangaconda.home = "/home/#{node.djangaconda.owner}"

# anaconda attributes
default.djangaconda.conda_version = 'miniconda-python3'
default.djangaconda.conda_flavor = 'x86_64' # should match VM
default.djangaconda.conda_accept_license = 'yes' # to accept license
default.djangaconda.conda_install_root = '/opt/anaconda'
default.djangaconda.conda_install_dir = "#{node.djangaconda.conda_install_root}/#{node.djangaconda.conda_version}"
default.djangaconda.conda_bin_dir = "#{default.djangaconda.conda_install_dir}/bin"

# django project attributes
default.djangaconda.project_install_method = 'create-new' #, 'git-clone', 
default.djangaconda.project_install_root = "#{node.djangaconda.home}"
default.djangaconda.project_parent_directory = nil # set in recipe::django, depends on install method
default.djangaconda.project_name = 'my_project'
default.djangaconda.project_gitrepo_name = "#{node.djangaconda.project_name}"
default.djangaconda.project_gitrepo_source = 'git://github.com/nareynolds/django-polls-tutorial.git'
default.djangaconda.project_gitrepo_branch = 'master'

# server attributes
default.djangaconda.server_type = 'development' #, 'nginx-gunicorn', 'apache-mod_wsgi'
default.djangaconda.server_start = true
default.djangaconda.gunicorn_workers = '3'
default.djangaconda.nginx_port = '8000'
default.djangaconda.nginx_domain = '127.0.0.1'

# databse attributes
# ...

# migrate project
default.djangaconda.project_migrate = false #, true

