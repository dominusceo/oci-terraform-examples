#! /bin/bash
# Author: Ricardo Carrillo ricardo.d.carrillo@oracle.com
# Goal: Setting environment variables on Unix and Linux Environment
#       If your Terraform configurations are limited to a single compartment or user, 
#		then using this bash_profile option be sufficient. 

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaar6q6nrtbkidcz6xnyl3lkqssk7c6nslpnu2mdjywtbppvz5txz2a"
export TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaanoui6jllobc2iubjyno2vvvv7flg4rsu37avw532zzygizgche7q"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaad5wkqrqw25rtgvltdblv5yhnvxg3c3ugzvurm6bp63yvppnbgx5q"
export TF_VAR_fingerprint="72:5f:c4:20:2b:b0:13:96:81:cb:67:2e:22:f7:75:f6"
export TF_VAR_region="us-sanjose-1"
export TF_VAR_private_key_path="~/.ssh/"
export TF_VAR_api_private_key="~/.ssh/api_key_private.pem"
export TF_VAR_ssh_public_key="~/.ssh/oci_api_public.pem"
export TF_VAR_selected_AD="DSdu:US-ASHBURN-AD-3"
#export TF_VAR_subnet_ocid="ocid1.subnet.oc1.[your subnet ocid]"
#All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
export TF_VAR_image_ocid="ocid1.image.oc1.us-sanjose-1.aaaaaaaa3stdbyfdqhcdykpzf7ndzwudklnp77wo5lym7rp33ysspk6o2m4q"
export TF_VAR_instance_shape="VM.Standard.E2.1.Micro"
export TF_VAR_config_file_profile="ORACLESECURITY"
