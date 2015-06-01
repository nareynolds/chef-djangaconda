# how to install django project
default.djangaconda.project_install_method = nil #, 'create-new', 'git-clone', 

# project location and name
default.djangaconda.project_directory = "#{node.anaconda.home}"
default.djangaconda.project_name = 'my_project'

# git repository of project
default.djangaconda.project_gitrepo_name = "#{node.djangaconda.project_name}"
default.djangaconda.project_gitrepo_source = 'git://github.com/nareynolds/django-polls-tutorial.git'
default.djangaconda.project_gitrepo_branch = 'master'

# ready project
default.djangaconda.project_migrate = false #, true

# server
default.djangaconda.server = 'development' #, 'apache-mod_wsgi', 'nginx-gunicorn'
