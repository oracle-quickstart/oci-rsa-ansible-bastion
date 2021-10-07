## Team Workflow
Our team's recommended method of deployment is driven by Terraform. The Ansible playbooks are bundled and uploaded to OCI 
Object Storage. These bundles are then pulled down from the bucket during instance bootstrapping in Terraform. 

Here is a link to our [Terraform Stack](https://github.com/oracle-devrel/terraform-oci-rsa-bastion)

Following are the steps used by our bootstrapping script to deploy this stack.

To run this playbook manually, this repository needs to first be bundled up with the dependencies and roles and uploaded to an 
object storage bucket as a `tgz` file.

Note: The instructions below use variables. Please check you have set all the required variables or that you have replaced them 
with your values.

Assuming you have cloned the repository and are in the repository root:

Command to install the Ansible roles
```
ansible-galaxy install -r requirements.yml -p ./roles
```

Command to bundle up the playbook. Here the `playbook_zip` variable is `target_dir/playbook_name`
```
tar -czf $playbook_zip $playbook_name
```

Command to upload the tar file to object storage
```
oci os object put -ns $namespace -bn $bucketname --file $playbook_zip --name ${playbook_name}.tgz
```

After terraform provisions the instances, the bootstrapping script pulls the appropriate tar file from object store and 
runs the playbook using the following command:

```
oci os object get -bn ${bootstrap_bucket} --file $PACKAGE_CACHE/${bootstrap_bundle} --name ${bootstrap_bundle}
```

Because we are not using ansible inventory to run the playbooks, the bootstrapping script runs the following command to 
launch the playbook directly on each of the hosts locally.

```
ansible-playbook -i localhost, $OCI_RSA_BASE/${playbook_name}/main.yml --connection=local
```

### First time Bastion pin

In order to log into the Bastion the first time, you will need your private SSH key (public key should have been provided 
as an input for Terraform). With that, you'll be prompted for a "One-time password (OATH) for opc" - the default value 
is: `560000`. Immediately scan the barcode using your authenticator of choice, or you will lose access to this host. 
If you can't log in, you will have to terminate the bastion and recreate it via Terraform.
