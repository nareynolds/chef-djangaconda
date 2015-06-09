# user attributes
default.djangaconda.owner = 'vagrant'
default.djangaconda.group = 'vagrant'
default.djangaconda.home = "/home/#{node.djangaconda.owner}"

# anaconda attributes
default.djangaconda.conda_version = '3-2.2.0'
default.djangaconda.conda_flavor = 'x86_64'
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

# database attributes
default.djangaconda.database_type = 'sqlite' #, 'postgresql', 'mysql'
default.djangaconda.database_name = 'db' # should match entry in settings.py
default.djangaconda.database_user = "#{node.djangaconda.owner}"
default.djangaconda.database_password = ''
default.djangaconda.database_migrate = true
default.djangaconda.postgresql_password = ''
default.djangaconda.postgresql_host = '127.0.0.1'
default.djangaconda.postgresql_port = '5432'
default.djangaconda.postgresql_listen_addresses = 'localhost'

# server attributes
default.djangaconda.server_type = 'django-dev' #, 'nginx-gunicorn', 'apache-mod_wsgi'
default.djangaconda.server_start = false
default.djangaconda.gunicorn_workers = '3'
default.djangaconda.nginx_port = '8000'
default.djangaconda.nginx_domain = '127.0.0.1'
default.djangaconda.collect_static_files = false
