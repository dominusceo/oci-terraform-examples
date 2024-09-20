#! /bin/bash
# Author: Ricardo Carrillo ricardo.d.carrillo@oracle.com
# Goal: Setting environment variables on Unix and Linux Environment
#       If your Terraform configurations are limited to a single compartment or user, 
#	then using this bash_profile option be sufficient. 

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaa2rk54ibdfxxemyrgkfsna3mzj5s2kihdoyz4riglujpsxymghrgq"
export TF_VAR_compartment_ocid="compartment_OCID"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaad5wkqrqw25rtgvltdblv5yhnvxg3c3ugzvurm6bp63yvppnbgx5q"
export TF_VAR_fingerprint="3e:48:9e:44:b4:23:3c:41:8e:94:03:d5:4a:83:73:5b"
export TF_VAR_region="us-sanjose-1"
export TF_VAR_private_key_path="~/.ssh/oci_api_private.pem"
export TF_VAR_api_private_key="~/.ssh/oci_api_private.pem"
export TF_VAR_ssh_public_key="~/.ssh/oci_api_public.pem"
export TF_VAR_selected_AD="DSdu:US-ASHBURN-AD-3"
export TF_VAR_subnet_ocid="ocid1.subnet.oc1.[your subnet ocid]"
#All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
export TF_VAR_image_ocid="ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
export TF_VAR_instance_shape="VM.Standard2.1"
export TF_VAR_config_file_profile="DEFAULT"
