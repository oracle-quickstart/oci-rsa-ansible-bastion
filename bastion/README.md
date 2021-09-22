ROLE: BASTION
=========

Installs the Bastion host running on Oracle Autonomous Linux. It will open SSH connection, and configure a one 
time password for the opc user to log into the host. It also installs the following packages:
- pam_oath
- oathtool
- gen-oath-safe


Requirements
------------

This role will work on:

- [Ansible core](https://docs.ansible.com/ansible-core/devel/index.html) >=  2.9.x
- [Oracle Autonomous Linux](https://www.oracle.com/linux/autonomous-linux/) >= 7.9


Role Variables
--------------

Setting the playbook name to `oci-rsa-ansible-bastion` to pass to the oci-rsa-ansible-base role. This role schedules the 
cron job to run Ansible at regular intervals. 
```
ansible_playbook_name: "oci-rsa-ansible-bastion"
```

Overrides the Wazuh manager and agent version to `4.1.5-1`
```
wazuh_manager_version: 4.1.5-1
wazuh_agent_version: 4.1.5-1
```

Used to automatically registers the Wazuh agent to the manager. The agent registration happens only once during the playbook 
run. If this process fails, then the user need to register the agents manually follwing the steps [here](https://documentation.wazuh.com/current/user-manual/registering/index.html).
```
wazuh_managers:
  - address: "{{ registration_address }}"
    port: 1514
    protocol: tcp
    api_port: 55000
    api_proto: https
    api_user: wazuh
    max_retries: 30
    retry_interval: 10
    register: yes
```

Default Variables
------------

The registration address is the domain name assigned to Wazuh load balancer. This is the default 
value used by Terraform but can be overridden.
```
registration_address: "wazuh-lb.wazuh-cluster.local"
```

Dependencies
------------

None

Example Playbook
----------------

Use the oci-rsa-ansible-base role before to install the required software. An example of how to use the role:

```
---
- hosts: all
  roles:
    - role: oci-rsa-ansible-base
      become: true
    - role: geerlingguy.clamav
      become: true
    - role: wazuh-ansible/wazuh-ansible/roles/wazuh/ansible-wazuh-agent
      become: true
    - role: bastion
      become: true
    - role: oci-rsa-ansible-base/wazuh_agent_configuration
      become: true
``` 

## License

This repository and its contents are licensed under [UPL 1.0](https://opensource.org/licenses/UPL).