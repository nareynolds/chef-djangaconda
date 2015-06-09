# djangaconda Cookbook

Chef cookbook for setting up a Django project with [Continuum Analytic](http://continuum.io/)'s [Anaconda](https://store.continuum.io/cshop/anaconda/).

A simple and complete example of how to use this cookbook for your own project can be found here: under construction...

Resources for best practices for testing and development of such a cookbook:
- [Git](https://git-scm.com/)
- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com) for development
- [Chef-DK](https://downloads.chef.io/chef-dk/)
  - [Chef](https://www.chef.io/chef/)
  - [Berkshelf 3](http://berkshelf.com/) for dependency resolution
  - [Chefspec](https://github.com/sethvargo/chefspec) for rapid testing
  - [Test Kitchen](https://github.com/test-kitchen/test-kitchen) for
comprehensive testing across multiple platforms, with tests written in
[serverspec](http://serverspec.org/)
  - [Foodcritic](http://acrmp.github.io/foodcritic/) for style checking


## Requirements

Required installations for the quickstart:
- [Git](https://git-scm.com/)
- [VirtualBox](https://www.virtualbox.org/) 4.0.x, 4.1.x, 4.2.x, or 4.3.x
- [Chef-DK](https://downloads.chef.io/chef-dk/)
- [Vagrant](https://www.vagrantup.com/) 1.6+
  - [vagrant-omnibus plugin](https://github.com/schisamo/vagrant-omnibus)
  - [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf): note
    that `>= 2.0.1` is required

Full list of cookbook dependencies for djangaconda:
- [anaconda](https://github.com/thmttch/chef-continuum-anaconda)
- [apt](https://github.com/opscode-cookbooks/apt)
- [build-essential](https://github.com/opscode-cookbooks/build-essential)
- [chef_handler](https://github.com/opscode-cookbooks/chef_handler)
- [chef_sugar](https://github.com/sethvargo/chef-sugar)
- [database](https://github.com/opscode-cookbooks/database)
- [dmg](https://github.com/opscode-cookbooks/dmg)
- [git](https://github.com/jssjr/git)
- [openssl](https://github.com/opscode-cookbooks/openssl)
- [packagecloud](https://github.com/computology/packagecloud-cookbook)
- [postgresql](https://github.com/hw-cookbooks/postgresql)
- [runit](https://github.com/hw-cookbooks/runit)
- [windows](https://github.com/opscode-cookbooks/windows)
- [yum](https://github.com/chef-cookbooks/yum)
- [yum-epel](https://github.com/chef-cookbooks/yum-epel)


## The Anaconda Cookbook
This awesome cookbook and more details about using it can be found at its repo: [https://github.com/thmttch/chef-continuum-anaconda](https://github.com/thmttch/chef-continuum-anaconda)


## Quickstart

The [Vagrantfile](Vagrantfile) is written to set up and run the well known Django 1.8 ["Polls Tutorial"](https://docs.djangoproject.com/en/1.8/intro/) project on an Ubuntu 14.04 virtual box provisioned with Django installed in a Python 3.4 Anaconda environment, PostgreSQL, Nginx, and Gunicorn. Please, note that the setup may take a while the first time Vagrant must download the Ubuntu box, and that it will take at least a few minutes to download the Anaconda installer.

```bash
# clone this repo
$> git clone https://github.com/nareynolds/chef-djangaconda.git

# change working directory
$> cd chef-djangaconda

# start up vagrant - may take a while
$> vagrant up
... lots of stuff...

# when it's done, point your web browser at http://localhost:8001/
# and explore the "Polls Turial" website

# you can ssh into your fully provisioned VM
$> vagrant ssh

# you'll find the "Polls Tutorial" project here:
$vagrant> ls django-polls-tutorial/
... project stuff...

# to access admin page, you need to create a superuser
cd django-polls-tutorial/
python manage.py createsuperuser
... enter a username, email, and password...

# now, point your web browser at http://localhost:8001/admin
# you should be able to login with the username you just created

# exit your VM
$vagrant> exit

# shut down the VM
$> vagrant destroy
```


## Usage

#### [djangaconda::default](recipes/default.rb)
This recipe simply calls the following recipes in an order that makes sense for setting up a django project.

#### [djangaconda::anaconda](recipes/anaconda.rb)
This will install Anaconda, and set the environment for all users.

#### [djangaconda::django](recipes/django.rb)
This will install Django into the Anaconda environment. Based on the attribute settings, it can then create a new Django project, git clone a project from a remote repository, or neither. By default these projects are installed in the home directory of the user set for the install of Anaconda (default is 'vagrant').

#### [djangaconda::database](recipes/database.rb)
The attribute settings will determine the database used for the project. The default database is SQLite, as this is the case for a newly create Django project, and Django will manage its creation. If a PostgreSQL database is selected, it will be installed, configured, and run. The default attribute settings will also execute a database migration of the Django project. Be sure your project's 'settings.py' file accurately reflects your choice of database.

#### [djangaconda::server](recipes/server.rb)
The attribute settings will determine the server used for the project. The default database is the Django development server. If a Nginx-Gunicorn server is selected, both will be installed and configured. Be sure your project's 'settings.py' file accurately reflects your choice of static-file handling. Set `node['djangaconda']['collect_static_files'] = true` to automatically execute a collection of your static files. The default attribute settings will also execute a restart of both servers.

Just include one of all of these recipes in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[djangaconda::default]",
  ]
}
```


## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['djangaconda']['create_project_name']</tt></td>
    <td>String</td>
    <td>Name of project to create</td>
    <td><tt>"my_project"</tt></td>
  </tr>
  <tr>
    <td><tt>['djangaconda']['clone_repo_name']</tt></td>
    <td>String</td>
    <td>Name of git repository to clone</td>
    <td><tt>"django-polls-tutorial"</tt></td>
  </tr>
  <tr>
    <td><tt>['djangaconda']['clone_repo_source']</tt></td>
    <td>String</td>
    <td>Source of git repository to clone</td>
    <td><tt>"git://github.com/nareynolds/django-polls-tutorial.git"</tt></td>
  </tr>
  <tr>
    <td><tt>['djangaconda']['clone_repo_branch']</tt></td>
    <td>String</td>
    <td>Branch of git repository to clone</td>
    <td><tt>"master"</tt></td>
  </tr>
  <tr>
    <td><tt>['djangaconda']['clone_repo_destination']</tt></td>
    <td>String</td>
    <td>Destination of where to clone the git repository</td>
    <td><tt>"#{node.anaconda.home}"</tt></td>
  </tr>
</table>


## Contributing

1. Fork the repository on Github

2. Create a named feature branch (like `add_component_x`)

3. Write your change

4. Write tests for your change (if applicable)

5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github


## Author

Nathaniel Reynolds (nathaniel.reynolds@gmail.com)

