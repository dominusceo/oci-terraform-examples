#! /bin/bash
# Author: Ricardo Carrillo ricardo.d.carrillo@oracle.com
# Goal: Setting environment variables on Unix and Linux Environment
#       If your Terraform configurations are limited to a single compartment or user, 
#	then using this bash_profile option be sufficient. 

export TF_VAR_tenancy_ocid="ocid1.tenancy.oc1..aaaaaaaawquag7eeulmm6e2yoykcvigene6piosc6rwgglznmt4d5iubifuq"
export TF_VAR_compartment_ocid="ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
export TF_VAR_user_ocid="ocid1.user.oc1..aaaaaaaakrlp2rwn3ouh45vplzlsqphkjo25i7dbodhl4wctcrzyt7sh4cta"
export TF_VAR_fingerprint="66:df:ee:f4:c3:fe:84:90:ac:d6:50:65:ca:2e:d6:57"
export TF_VAR_region="mx-queretaro-1"
export TF_VAR_private_key_path="~/.ssh/oci_api_private.pem"
export TF_VAR_api_private_key="~/.ssh/oci_api_private.pem"
export TF_VAR_ssh_public_key="~/.ssh/general.key"
export TF_VAR_selected_AD="ERDj:MX-QUERETARO-1-AD-1"
export TF_VAR_subnet_ocid="ocid1.subnet.oc1.[your subnet ocid]"
#All images: https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
export TF_VAR_image_ocid="ocid1.image.oc1.mx-queretaro-1.aaaaaaaaubny6r5o3e3ejhn6klfhdt3pveien5ohxvvd54ugy6wspxa5wb6a"
export TF_VAR_instance_shape="VM.Standard4.Flex"
export TF_VAR_config_file_profile="DEFAULT"