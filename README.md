# djangaconda Cookbook

Chef cookbook for installing a Django project with [Continuum Analytic](http://continuum.io/)'s [Anaconda](https://store.continuum.io/cshop/anaconda/)

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

Full list of required cookbook:
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
$> git clone https://github.com/nareynolds/vagrant-chef-solo-anaconda3.git

# change working directory
$> cd vagrant-chef-solo-anaconda3

# start up vagrant - may take a while
$> vagrant up
...

# ssh into your fully provisioned VM
$> vagrant ssh

# check your version of Anaconda
$vagrant> conda --version
conda 3.10.0

# and have fun...

# exit your VM
$vagrant> exit
```

Include any additional packages you want install by modifying [cookbooks/anaconda-packages/recipes/default.rb](cookbooks/anaconda-packages/recipes/default.rb).


Attributes
----------
TODO: List your cookbook attributes here.

e.g.
#### django-example::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['django-example']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### django-example::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `django-example` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[django-example]"
  ]
}
```

## Contributing

1. Fork the repository on Github

2. Create a named feature branch (like `add_component_x`)

3. Write your change

4. Write tests for your change (if applicable)

5. Run the tests, ensuring they all pass

6. Submit a Pull Request using Github


## Author

Nathaniel Reynolds (nathaniel.reynolds@gmail.com)

