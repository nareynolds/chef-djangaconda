# djangaconda Cookbook

Chef cookbook for provisioning a Django project with [Continuum Analytic](http://continuum.io/)'s [Anaconda](https://store.continuum.io/cshop/anaconda/).

A simple and complete example of how to use this cookbook for your own project can be found here: ....

Resources for best practices for testing and development of such a cookbook:
- [git](https://git-scm.com/)
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

Required for the quickstart:
- [git](https://git-scm.com/)
- [VirtualBox](https://www.virtualbox.org/) 4.0.x, 4.1.x, 4.2.x, or 4.3.x
- [Vagrant](https://www.vagrantup.com/) 1.6+
  - [vagrant-omnibus plugin](https://github.com/schisamo/vagrant-omnibus)
  - [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf): note
    that `>= 2.0.1` is required

Full list of cookbook dependencies for djangaconda:
- [anaconda](https://github.com/thmttch/chef-continuum-anaconda)
- [apt](https://github.com/opscode-cookbooks/apt)
- [build-essential](https://github.com/opscode-cookbooks/build-essential)
- [chef_handler](https://github.com/opscode-cookbooks/chef_handler)
- [dmg](https://github.com/opscode-cookbooks/dmg)
- [git](https://github.com/jssjr/git)
- [packagecloud](https://github.com/computology/packagecloud-cookbook)
- [runit](https://github.com/hw-cookbooks/runit)
- [windows](https://github.com/opscode-cookbooks/windows)
- [yum](https://github.com/chef-cookbooks/yum)
- [yum-epel](https://github.com/chef-cookbooks/yum-epel)


## The Anaconda Cookbook
This awesome cookbook and more details about using it can be found at its repo: [https://github.com/thmttch/chef-continuum-anaconda](https://github.com/thmttch/chef-continuum-anaconda)


## Quickstart

The [Vagrantfile](Vagrantfile) is written to get your Anaconda environment up and running with minimal effort (though it will take at least a few minutes to download the Anaconda installer itself).

```bash
# clone this repo
$> git clone https://github.com/nareynolds/chef-djangaconda.git

# change working directory
$> cd chef-djangaconda

# start up vagrant - may take a while
$> vagrant up
...

# ssh into your fully provisioned VM
$> vagrant ssh

# check your version of Anaconda
$vagrant> conda --version
conda 3.12.0

# ...have fun...

# exit your VM
$vagrant> exit
```


## Usage

#### [djangaconda::default](recipes/default.rb)
This will install Anaconda, set the environment for all users, and install Django. Include any additional packages you want installed here. by modifying .

#### [djangaconda::create](recipes/create.rb)
This will create a new Django project in the home direcotry of the user set for the install of Anaconda (default is 'vagrant'). Set the project name via the 'create_project_name' attribute.

#### [djangaconda::clone](recipes/clone.rb)
This will git clone a project to the home direcotry of the user set for the install of Anaconda (default is 'vagrant'). Set the repo's name, source, branch, and destination via the attributes 'clone_repo_name', 'clone_repo_source', 'clone_repo_branch', 'clone_repo_destination', respectively.

Just include one of all of these recipes in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[djangaconda::default]",
    "recipe[djangaconda::create]",
    "recipe[djangaconda::clone]",
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
    <td><tt>...</tt></td>
  </tr>
  <tr>
    <td><tt>['djangaconda']['clone_repo_source']</tt></td>
    <td>String</td>
    <td>Source of git repository to clone</td>
    <td><tt>...</tt></td>
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

