#Create vagrant subnet
hammer -u admin -p puppetlabs subnet create --name="intranet" --domain-ids 1 --gateway 10.20.2.2 --dns-primary 10.20.2.3 --mask 10.20.2.255 --network 10.20.2.0

#Associate the vagrant.internal domain with the Default_Location
hammer -u admin -p puppetlabs location add-domain --domain-id 1 --name 'Default_Location'

#Create Red Hat 7.0 Installation Media
hammer -u admin -p puppetlabs medium create --name 'Red Hat 7.0' --operatingsystem-ids 1 --os-family 'Redhat' --path http://osmirror.delivery.puppetlabs.net/rhel7latestserver-x86_64/disc1

#Associate x86_64 to Red Hat 7.0 OS
hammer -u admin -p puppetlabs os add-architecture --architecture-id 1 --id 1
#Associate Kickstart Default partition table to Red Hat 7.0 OS
hammer -u admin -p puppetlabs os add-ptable --ptable-id 7 --id 1

#Install the provisioning templates
hammer -u admin -p puppetlabs template create --name 'pe-puppet.conf' --operatingsystem-ids 1 --type snippet --file /vagrant/satellite/templates/pe-puppet.conf.erb
hammer -u admin -p puppetlabs template create --name 'Satellite Kickstart Default with Puppet Enterprise' --operatingsystem-ids 1 --type provision --file /vagrant/satellite/templates/sat_kickstart_default_w_pe.erb

#Associate PXE script with Red Hat 7.0
hammer -u admin -p puppetlabs template add-operatingsystem --id 15 --operatingsystem-id 1

#Set RedHat 7.0 default template Boot disk iPXE - generic host
hammer -u admin -p puppetlabs os set-default-template --config-template-id 15 --id 1

#Set RedHat 7.0 default template Satellite + PE Kickstart Default
hammer -u admin -p puppetlabs os set-default-template --config-template-id 39 --id 1

#Create Wordpress hostgroup
hammer -u admin -p puppetlabs hostgroup create --name 'wordpress' --operatingsystem-id 1 --domain-id 1 --subnet-id 1 --architecture-id 1 --medium-id 7 --ptable-id 7
#Set PE CA parameter
hammer -u admin -p puppetlabs hostgroup set-parameter --hostgroup wordpress --name 'pe_puppet_ca' --value 'master'
#Set PE master parameter
hammer -u admin -p puppetlabs hostgroup set-parameter --hostgroup wordpress --name 'pe_puppet_master' --value 'master'
#Set PE role
hammer -u admin -p puppetlabs hostgroup set-parameter --hostgroup wordpress --name pe_role --value wordpress

#Associate the hostgroup with the Default_Location
hammer -u admin -p puppetlabs location add-hostgroup --hostgroup 'wordpress' --name 'Default_Location'
