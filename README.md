# Puppet Enterprise Demo Environment

#### Table of Contents

1. [Overview](#overview)
2. [Quick Start](#quick-start)
    * [Access the Puppet Enterprise Console](#access-the-puppet-enterprise-console)
3. [Selecting Demos](#selecting-demos)
4. [Creating a New Demo](#creating-a-new-demo)
    * [Adding VMs](#adding-vms)
    * [Adding VM Roles](#adding-vm-roles)
    * [Adding Vagrant Boxes](#adding-vagrant-boxes)
    * [Modifying the PE Master](#modifying-the-pe-master)
        * [Puppetfile](#puppetfile)
    * [Using YAML ERB templates](#using-yaml-erb-templates)


## Overview

This tool provides a quick way to bootstrap an example deployment of Puppet
Enterprise, complete with a master and several managed nodes running different
operating systems. It's intended to give you an easy way to demonstrate Puppet
Enterprise, Puppet Apps, and partner integrations  on a single laptop without 
any outside infrastructure.

## Quick Start

The following command will install Puppet, Virtualbox, Vagrant, and the
necessary vagrant plugins

      $ curl http://links.puppetlabs.com/pe-demo-install-script | bash

Once done, you can bring up a single master by running `vagrant up`

It's going to take a while for the VM to come up and be fully configured.

The above script ensures the following software is installed on your system:

* Puppet (gem if not already present)
* librarian-puppet (gem)
* Virtualbox 5.0
* Vagrant (latest)
* vagrant-oscar plugin
* vagrant-vbox-snapshot plugin

### Access the Puppet Enterprise Console

You'll be back at the command prompt, but the puppet master is still running in
the background. Before you can get to the console, you'll need to figure out
where it is:

        $ vagrant hosts list

The response should look something like `10.20.1.1 master`, meaning that the
`master` VM has the IP address of `10.20.1.1`. Next, just point your browser to
`https://10.20.1.1` (or whatever the actual IP address is) and log in with the
username `admin@puppetlabs.com`, password `puppetlabs`. Don't worry if you get
a warning about the security certificate; that really won't affect anything. 

When you log in, you may notice that there's just one node listed: `master`.
Not a bad start, but also not a great example of Puppet in action. In the next
section, you'll add some additional nodes to manage.

## Selecting Demos

The default demo consists of a single Puppet Enterprise monolithic master.  There
are no agents nor any pre-canned demos for middleware, partner integrations, or
use cases.

To list available demo environments, use `vagrant demo list`.  This will give
you currently loaded demo environments as well as the ones that are available
to select.

To select a demo, use `vagrant demo use demo_name`.  Multiple environments can
be selected by providing a comma separated list of all the environments you
want to use.  of the demos your want to run.

        $ vagrant demo use demo_a,demo_b

Once done, you'll be able to use vagrant normally to start and provision the
new VMs.

        $ vagrant status

        master                    running (virtualbox)
        wordpress                 not created (virtualbox)
        cisco                     not created (virtualbox)

## Creating a new demo

To create a new demo, just create a directory by the demo name in the project
root. Inside your demo directory, you'll specify a demo.yaml file, the VMs,
roles, and Vagrant boxes you'll need to build your demo environment.

It is highly recommended that your demo inherit the base demo, which is just a
Puppet Enterprise master, so you will just need to worry about any additional
VMs you'll need, as well as any modifications to the PE master such as
classification rules.

### demo.yaml

In your demo environment's directory, create a demo.yaml file.  This file will
specify all the metadata about your demo. All keys below are optional except
the directory key.

         ---
         demo:
            demo_name:
               inerits: base
               description: "My demo's description"
               directory: directory/relative/to/project/root
               info_url: 'https://confluence.puppetlabs.com/demo/information'

### Adding VMs

In your demo directory, create a **vms.yaml** file.  Inside, specify a list of
all the VMs you'll need using a format something like this:

        ---
        vms:
          - name: "vm1"
            box:  "puppetlabs/centos-7.0-64-nocm"
            roles: [ "agent" ]
          - name: "vm2"
            box:  "puppetlabs/centos-7.0-64-nocm"
            roles: [ "agent", "example_role2" ]


### Adding VM roles

In the demo directory, create a **roles.yaml** file. Inside, specify the list
of roles using a format something like this: 

        ---
        roles:
          example_role:
            private_networks:
              - ip: '0.0.0.0'
                auto_network: true
            provisioners:
              - type: hosts
              - type: pe_bootstrap
              - type: shell
                inline: |-
                  echo 'demo'

### Adding vagrant boxes

In the demo directory, create a **boxes.yaml** file. Inside, specify the list
of roles using a format something like this: 

        ---
        boxes:
          'rhel-70-x64-vbox-nocm': 'http://int-resources.ops.puppetlabs.net/vagrant/puppetless_boxes/rhel-70.virtualbox.box'

### Modifying the PE master

You can specify Puppet code to run on the PE master. This is useful to create
node groups in the classifier, stage files and repositories, set up packages,
and more.  Note this is entirely optional. 

In your demo directory, create a directory called **puppet**. Inside the puppet
directory, create a **manifests** directory. All Puppet manifests go here. No
classification is necesary.  When Puppet is run on the master, all .pp files in
your demo's manifests directory will be combined into a single manifest.  This
means every .pp file can contain raw resources without any classes.

#### Puppetfile

If your demo's Puppet manifests make use of modules, you can specify a
Puppetfile in your demo's **puppet** directory. Note the Puppetfile only
specifies modules to be used when provsiioning your specific demo.  The modules
will not be installed on the master in a global modulepath.


### Using YAML ERB templates

Sometimes you need to put some logic or environment variables into your yaml
configs.  To do so, you can write an ERB template that outputs valid YAML for
your VMs, roles, boxes, etc.  Instead of using the .yaml file extension, using
.yaml_erb file extension.  For example: **roles.yaml_erb**. It will
automatically be parsed as a template. As long as its result is valid YAML, it
will be treated as a static .yaml file. 
