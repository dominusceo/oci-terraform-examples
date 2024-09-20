---
# Welcome to OCI-INLAB laboratories
This repository contains Terraform code to deploy an IaC (Infrastructure as Code) basic architecture divided in 2 labs (**lab-01** and **lab-02**), now, if if you're looking for more advanced excersises, maybe will be useful you
can check the [Oracle Architecture Center](https://docs.oracle.com/solutions/?q=terraform&cType=reference-architectures&sort=date-desc&lang=en) where you will find more advanced architectures with terraform code included.

## Prerequisites to execute terraform to prepare the LAB-01 (OCI-INLAB) and LAB-02 (Resource Manager):
On your must have the following points covered in order to perform **LAB-01** (OCI-INLAB):
* You must have a Oracle Cloud Infrastructure (OCI) subscription or if not is possible you can get Free Account or paid Account through a [Oracle Free Tier](https://www.oracle.com/cloud/free/). Which any of both accounts you must have an user account with enough privileges to deploy infrastructure with Terraform. 
Here are listed some of the basic requeriments to perform this labs:
 
* A cloud admin must define [API Keys](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/apisigningkey.htm) for each user (cloud account assigned) to perform terraform deployments, also it's going to be needed information related from:
  - Tenancy OCID
  - User OCID
  - Compartment OCID
  - Availability Domain name
  - Fingerprint
  - Region Name
* Depending of how would you like to perform terraform lab, you should download terraform binary file for your local/remote machine (for LABs and operative environments we recommend to use terraform >= 0.12.20 or greater).
* SSH Client and SSH pair keys accordingly with [Way to install/use terraform options](#ways-to-use-install-or-install-terraform-client) 


## Ways to use or install terraform client
Option to use or install terraform:

![Image title](img/option-install.png)
Consider the lab can be performed base in 3 different options:
* **Option 1 - Use terraform with [Cloud Shell](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm)**: it is a web browser-based terminal accessible from the Oracle Cloud Console. 
* **Option 2 - Cloud Development Kit**: The Terraform provider is pre-installed on the [Oracle Linux Cloud Developer](https://docs.oracle.com/en-us/iaas/oracle-linux/developer/index.htm) platform image. The Oracle Cloud Development Kit includes Terraform and the OCI Terraform provider, and preconfigures the required authorization.
* **Option 3 - Virtual Machine in cloud**: Install terraform cli and components (it, oci-cli, etc.) enabling repos.

### Option 1: Use terraform with Cloud Shell 
Cloud Shell is free to use (within monthly tenancy limits), and provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI, a pre-authenticated Ansible installation, and other useful tools for following Oracle Cloud Infrastructure service tutorials and labs. Cloud Shell is a feature available to all OCI users:
- It is accessible from the OCI Console
- An ephemeral machine to use as a host for a Linux shell, pre-configured with the latest version of the OCI Command Line Interface (CLI) and a number of useful tools
- 5GB of storage for your home directory
- A persistent frame of the Console which stays active as you navigate to different pages of the console

You can start Cloud Shell from your OCI Console.
 
### Option 2: Cloud Development Kit
This second option, you can install [Oracle Linux Cloud Developer](https://docs.oracle.com/en-us/iaas/oracle-linux/developer/index.htm) platform image from OCI consol instance subsection, or you can use [Resource Manager](https://docs.oracle.com/en-us/iaas/Content/ResourceManager/Tasks/devtools.htm) to preinstall this distro within your compartment. 


### Option 3: Local Machine as Client 
For this case, the cloud admin should install several components related with IaS deployment with terraform:

* Install the Operating System based on platform images

* If you consider install Oracle Linux, you can perform the installation and the enablement of the repositories required. Considering is a Linux OL8 or RHEL 8:
- For Oracle Linux 8 
```
$sudo dnf -y install oraclelinux-developer-release-el8
$sudo yum-config-manager --enable ol8_developer
```
- For RHEL 8 download RPM from YUM oracle repositories directly:
```
wget -c https://yum.oracle.com/repo/OracleLinux/OL8/baseos/latest/x86_64/getPackageSource/oraclelinux-developer-release-el8-1.0-7.el8.src.rpm
```

* Also it's not mandatory but convenient to install OCI client (OCI-CLI) [Consider configure previusly oci-cli to corroborate interaction with OCI Cloud](https://docs.oracle.com/en-us/iaas/Content/API/Concepts/cliconcepts.htm):
```
$sudo dnf install python36-oci-cli
```

* Alternativly, get git utility to manage code projects and perform the lab cloning:
```
$sudo yum install git
```
* If it was downloaded and enable the Developer Repository, you can install the terraform client and terraform provider performing by:
```
$sudo yum install terraform
$sudo yum install terraform-provider-oci
```
* Test terraform installation opening a terminal window and run the following command to test your installation:
```
$terraform -v
```

# Other considerations
For this labs consider the following observations:
- The **tfVariables.sh** script contains default global variables to be defined or used with Terraform client.
- Take a look to our [Oracle Architecture Center](https://docs.oracle.com/solutions/?q=terraform&cType=reference-architectures&sort=date-desc&lang=en)
- You can take this PDF document in order to take it as reference or [guide to install Terraform in windows client](choco_install-terraform.pdf)
- You can take this URL reference to [Install Linux on Windows with WSL](https://learn.microsoft.com/en-us/windows/wsl/install) and use a native Oracle Linux container natively in your Windows machine or if you prefer you can [Download alternative PDF](wsl-windows-installation.pdf) in order to perform the installation of WSL.

# OCI LAB-01 & LAB-02
## LAB-01 (OCI-INLAB) Basic deployment architecture
For the **LAB-01** the components can be depicted as follow:
![Image title](img/OCI-INLAB-01.png)

Access [LAB-01 (OCI-INLAB) Basic deployment architecture](https://github.com/dominusceo/oci-terraform-lab/tree/main/lab-01)

## LAB-02 Basic terraform deployment with OCI Resource Manager
For the **LAB-02** the components can be depicted as follow:
![Image title](img/OCI-INLAB-02.png)

Access [LAB-02 Basic Deployment with OCI Resource Manager](https://github.com/dominusceo/oci-terraform-lab/tree/main/lab-02)

## Let's get started
Clone the git project from Github, in order to perform this labs:
```
$git clone https://github.com/dominusceo/oci-terraform-lab.git
```
