## OCI-RSA-ANSIBLE-BASTION
This stack creates a Bastion host running on Oracle Autonomous Linux. It will open SSH connection, and configure a one 
time password for the opc user to log into the host. A bastion is a host which acts as a single point of entry to hosts 
within the private network. 

## Ansible Role: wazuh-ansible
We are using **Galaxy** which provides pre-packaged units of work known to Ansible as roles and collections. Content from 
roles and collections of the **wazuh-ansible** are referenced in oci-rsa-ansible-bastion. This playbook installs and 
configures Wazuh agent and manager.

## Ansible Role: oci-rsa-ansible-base
Installs base packages and sets configuration for general security, monitoring, and auditing purposes. More information 
on the oci-rsa-ansible-base can be found [here](PLACEHOLDER).

## Requirements

- [Ansible core](https://docs.ansible.com/ansible-core/devel/index.html) >= 2.9.x
- [Oracle Autonomous Linux](https://www.oracle.com/linux/autonomous-linux/) >= 7.9

Dependencies
------------

A list of other roles hosted on Galaxy:
* [ansible-wazuh-agent](https://github.com/wazuh/wazuh-ansible/tree/master/roles/wazuh/ansible-wazuh-agent): This role 
  will install and configure a Wazuh Agent.
  
A list of other roles hosted on Github:
* [oci-rsa-ansible-base](PLACEHOLDER): Installs base packages and sets configuration for general security, monitoring, 
  and auditing purposes.
  - [wazuh_agent_configuration](PLACEHOLDER): It installs the Wazuh agent configuration for local file monitoring on the
  instance.
## Branches
* `main` branch contains the latest code.

## Usage

This is a wrapper which configures the Bastion host. To deploy the infrastructure and configure the Bastion service on 
instance node, our team recommends a specific workflow. Detailed explanation of the recommended workflow can be found 
[here](WORKFLOW.md). 

### Running the Playbook

There are multiple ways to run Ansible playbook, but for our project we choose to pull down the bundled playbook from 
the OCI Object Storage bucket and then run the following command to configure each of the hosts locally.

```
ansible-playbook -i localhost, $OCI_RSA_BASE/${playbook_name}/main.yml --connection=local
```
### First Time Login

The initial one time pin for the opc user is `56000`. You'll be prompted for this after authenticating with your SSH key 
(defined during host provisioning). After the first login, you will be prompted to set up an authenticator program of your choice. If you fail to do so, you will lose access to the host.

## The Team
This repository was developed by the Oracle OCI Regulatory Solutions and Automation (RSA) team.

## How to Contribute
Interested in contributing?  See our contribution [guidelines](CONTRIBUTE.md) for details.

## License
This repository and its contents are licensed under [UPL 1.0](https://opensource.org/licenses/UPL).