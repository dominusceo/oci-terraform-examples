---
# LAB-03 - Terraform integration with Ansible
For this lab, we are going to perform the integration of Terraform from OCI with Oracle Cloud Infrastructure Ansible Collection. Ansible Collections provides an easy way to provision and manage resources in Oracle Cloud Infrastructure using Ansible.

OCI supports the use of Ansible modules to automate cloud infrastructure provisioning and configuration, orchestration of complex operational processes, and deployment and update of your software assets.

Ansible tracks your resources using inventory lists. The inventory can be a simple static .ini file or dynamically created, where a plugin assembles an up-to-date infrastructure inventory. 

Ansible playbooks automate configuration, deployment, and orchestration tasks. Ansible playbooks use a declarative language (YAML) that allows you to describe infrastructure configuration, deployment policy, and the orchestration of complex process steps. OCI provides a set of Example Playbooks for your review.

> **The OCI Ansible collection supports Ansible Tower, AWX, and Oracle Linux Automation Manager.**
> ** This collection replaces the [legacy modules](https://github.com/oracle/oci-ansible-modules). Refer to the [Migration Guide](https://github.com/oracle/oci-ansible-collections/blob/master/MigrationGuide.md) for best migration practices.**

Ansible [released Collections](https://www.ansible.com/blog/getting-started-with-ansible-collections) as part of the Ansible 2.9 release.
Ansible recommends Collections as the recommended method of packaging and releasing modules. 
With the creation of Oracle Cloud Ansible Collection, we are providing two user benefits:
 * **Faster Availability** - Oracle Cloud Ansible Modules will now be available to users at a faster pace on Ansible Galaxy. 
 * **Wider Coverage** - Support for the majority of the Oracle Cloud services.

We have also added a new [User Guide](https://github.com/oracle/oci-ansible-collections/blob/master/UserGuide.md) to highlight new features and best practices for using the new modules.

### Migration from Legacy Modules

We recommend migrating from the [legacy modules](https://github.com/oracle/oci-ansible-modules) since they will be deprecated in the near future.
Please expect a few breaking changes while migrating from legacy modules to the new collection modules.
We recommend you to refer to the [Migration Guide](https://github.com/oracle/oci-ansible-collections/blob/master/MigrationGuide.md) for breaking changes.
Also, the new modules are renamed to use the service name as a prefix.

#### Currently Supported Services 
We support almost all the of [OCI Cloud services](https://docs.cloud.oracle.com/en-us/iaas/Content/services.htm) with very few exceptions.
For the complete list of supported services, please check the [modules list](https://oci-ansible-collection.readthedocs.io/en/latest/collections/oracle/oci/index.html).


## Pre-requisites for Using Ansible with Oracle Cloud Infrastructure

- You must have an Oracle Cloud Infrastructure account.
- You must have a user in that account in a security group with a policy that grants necessary permissions for working with resources in the account compartments.
- You must have the necessary credentials and OCID information.
- Install **python>=3.6**

### Installation
#### Oracle Linux 7
```bash
sudo yum-config-manager --enable ol7_developer
sudo yum install -y oracle-epel-release-el7
sudo yum-config-manager --enable ol7_developer_EPEL
sudo yum install -y oci-ansible-collection
```
#### Oracle Linux 8

```bash
sudo yum-config-manager --enable ol8_developer
sudo yum install -y oracle-epel-release-el8
sudo yum-config-manager --enable ol8_developer_EPEL
sudo yum install -y oci-ansible-collection
```

#### Linux/macOS

```bash
curl -L https://raw.githubusercontent.com/oracle/oci-ansible-collection/master/scripts/install.sh | bash -s -- --verbose
```
#### For more info about installation and troubleshooting check the [Installation Guide](https://github.com/oracle/oci-ansible-collections/blob/master/InstallationGuide.md).
### Test the Installation

To test the installation of the RPM and configuration of the SDK, you can run a sample Ansible playbook.

#### Oracle Linux 7
If you're using Oracle Linux 7, use the following command to test your installation:
```
ansible-3 localhost -m oracle.oci.oci_object_storage_namespace_facts
```
#### Oracle Linux 8
If you're using Oracle Linux 8, use the following command to test your installation:
```
ansible localhost -m oracle.oci.oci_object_storage_namespace_facts
```

## Samples and Solutions

The project includes a catalog of Oracle Cloud Infrastructure Ansible module samples that illustrate using the modules 
to carry out common infrastructure provisioning and configuration tasks.
* The samples are organized in groups associated with Oracle Cloud Infrastructure services under [the samples directory on GitHub](https://github.com/oracle/oci-ansible-collections/tree/master/samples).
Begin by reviewing the Readme.md file that you will find in each sample's root directory.
* The solutions are available under [the solutions directory on GitHub](https://github.com/oracle/oci-ansible-collections/tree/master/solutions)

## Documentation
Module HTML documentation is available on [readthedocs.io](https://oci-ansible-collection.readthedocs.io/en/latest/collections/oracle/oci/index.html).

To view the module documentation, use this command:
```bash
ansible-doc oracle.oci.[module_name]
```
General documentation can be found [here](https://docs.cloud.oracle.com/iaas/Content/API/SDKDocs/ansible.htm).
---
# Execute Ansible  from Terraform
```bash
provisioner "local-exec" {
   command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ${var.user} -i '${self.ipv4_address},' --private-key ${var.ansible_ssh_private_key} setup.yml"
}
```