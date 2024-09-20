variable "compartment" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Oracle Cloud Compute Compartment where the infra will be deployed"
}

variable "release" {
  description = "Reference Architecture Release (OCI Architecture Center)"
  default     = "1.1"
}

# Required by the OCI Provider
variable "compartment_ocid" {
  type        = string
  default     = "ocid1.compartment.oc1..aaaaaaaawplfybzszx4gaaupjcy3ftfpebgh7bumrkzsglchoandq3gtckya"
  description = "Oracle Cloud Compute Compartment where the infra will be deployed"
}

variable "tenancy_ocid" {
  type        = string
  default     = "ocid1.tenancy.oc1..aaaaaaaawquag7eeulmm6e2yoykcvigene6piosc6rwgglznmt4d5iubifuq"
  description = "Oracle Cloud Identifier tenancy"
}

variable "user_ocid" {
  type        = string
  default     = "ocid1.user.oc1..aaaaaaaakrlp2rwn3ouh45vplzlsqphkjo25i7dbodhl4wctcrzyt7sh4cta"
  description = "Oracle Cloud Identifier user"
}

variable "fingerprint" {
  type        = string
  default     = "66:df:ee:f4:c3:fe:84:90:ac:d6:50:65:ca:2e:d6:57"
  description = "Oracle Cloud Fingerprint for the key pair"
}

variable "private_key" {
  type    = string
  default = "~/.ssh/oci-console-private.pem"
}

variable "oci_region" {
  type        = string
  default     = "mx-queretaro-1"
  description = "Oracle Cloud region"
}

variable "ad_list" {
  type        = list(any)
  default     = ["ERDj:MX-QUERETARO-1-AD-1"]
  description = "Availability Domain in us-sanjose-1 region"
}

variable "instance_shape" {
  #default = "VM.Standard2.1"
  default = "VM.Standard.E4.Flex"
}

variable "ad-domain" {
  type        = string
  default     = "ERDj:MX-QUERETARO-1-AD-1"
  description = "Availability domain in san jose"
}

// Data related with the internal user
variable "user-data" {
  default = <<EOF
#!/bin/bash -x
echo '################### webserver userdata begins #####################'
touch ~/userdata.$(date +%s).start

# echo '########## yum update all ###############'
# yum update -y

echo '########## basic webserver ##############'
yum install -y httpd openssl wget mod_ssl
systemctl enable  httpd.service
systemctl start  httpd.service
echo '<html><head></head><body><pre><code>' > /var/www/html/index.html
echo '<b>' $(hostname) '</b>'  >> /var/www/html/index.html
echo '' >> /var/www/html/index.html
#cat /etc/os-release >> /var/www/html/index.html
sudo mkdir -p /var/www/html/img
sudo mkdir -p /etc/pki/CA/certs/
sudo chcon -Rv --reference /etc/pki/tls/ /etc/pki/CA
sudo wget  https://docs.oracle.com/en-us/iaas/Content/Resources/Images/loadBalancer3adRegional.png -O /var/www/html/img/loadbalancer-reg.png
sudo chown -R apache:apache  /var/www/html/
echo '<img src="img/loadbalancer-reg.png" alt="Load Balancer Regional">'>> /var/www/html/index.html
echo '</code></pre></body></html>' >> /var/www/html/index.html

echo '-----BEGIN CERTIFICATE-----
MIIEEzCCAvsCFEsKbkkbI5Y8t+bfPkDNAWawvptJMA0GCSqGSIb3DQEBCwUAMIHE
MQswCQYDVQQGEwJNWDEZMBcGA1UECAwQQ2l1ZGFkIGRlIE1leGljbzEZMBcGA1UE
BwwQQ2l1ZGFkIGRlIE1leGljbzEaMBgGA1UECgwRU1NMIENBIFJlY29nbml6ZWQx
KjAoBgNVBAsMIUV4YW1wbGUgT3JhY2xlIExBRCBUZWNoIENsb3VkIEluYzEXMBUG
A1UEAwwOKi5vZXhhbXBsZS5jb20xHjAcBgkqhkiG9w0BCQEWD2NhQG9leGFtcGxl
LmNvbTAgFw0yMzExMTQwMzA1MTNaGA8yMTYwMTAwNjAzMDUxM1owgcQxCzAJBgNV
BAYTAk1YMRkwFwYDVQQIDBBDaXVkYWQgZGUgTWV4aWNvMRkwFwYDVQQHDBBDaXVk
YWQgZGUgTWV4aWNvMRowGAYDVQQKDBFTU0wgQ0EgUmVjb2duaXplZDEqMCgGA1UE
CwwhRXhhbXBsZSBPcmFjbGUgTEFEIFRlY2ggQ2xvdWQgSW5jMRcwFQYDVQQDDA4q
Lm9leGFtcGxlLmNvbTEeMBwGCSqGSIb3DQEJARYPY2FAb2V4YW1wbGUuY29tMIIB
IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv2fZqu6AEFRZLISLvi6dBO65
jXrCRixuud7Ahb45rk7ISmhvXrMR7ZwzYXXGPqgio+yhK/oeDVEbEvPKMPB7EgPA
tEZk6obVP1ifbxwNKO1gdvj1fw3sorPENaJR0Gotbl8CXnU2fC30i5GlVJt+cbrb
mc/mxbAw7QQwOD2k6iEIrcR+uRCq11ebP6JbNgYFtSt/xImg1Ri6oeVfJA8mxPwo
x/DgIOjxGWVMQOYek3n3HH813tbzXrpN++yUaYyjZ8Ff1o4RIh9C0yrUnUZfqR/q
SoRBt3yErf+cEdtkqzlobC84SB0MOcoLjjZTGuo+xAaZAsqloGZDHi0IQm02gwID
AQABMA0GCSqGSIb3DQEBCwUAA4IBAQDH01wHbJZ7TzhCUwkxrx0OxcEnpN7vg7gK
Y65oMO9GfmpTnx2y+d8LI96fHPc6CxUy7+2PVZLrxxBXlpiqRgb/6VDqsa/hwta7
GRL9rnhNzoPTeHNizfeo2BkpctmAVlutY1m/1IJqF3ZdfeB64YtKateOrhLedoaF
k6W0/k+s/Z4JWO4yPeklXQsgOb1B4JpQXwzCcvqbMXtUb2sNiZDcrOClF6mt4GgC
F+prCNajDDUGkD43cfFJeWxO1GYLiXVBrwJjbSn1jQL8vq0UHzs+rZlha/b3FaT7
p9p+QHbSqchWMiPfbOHy/5NqgEAsWt6+DvSye1HW/609+W20YO9b
-----END CERTIFICATE-----' > /etc/pki/tls/certs/loadbalancer.crt
echo '-----BEGIN CERTIFICATE-----
MIIEETCCAvkCFFX1iMnSAGEa2OTq/KTwX4vcYUEwMA0GCSqGSIb3DQEBCwUAMIHE
MQswCQYDVQQGEwJNWDEZMBcGA1UECAwQQ2l1ZGFkIGRlIE1leGljbzEZMBcGA1UE
BwwQQ2l1ZGFkIGRlIE1leGljbzEaMBgGA1UECgwRU1NMIENBIFJlY29nbml6ZWQx
KjAoBgNVBAsMIUV4YW1wbGUgT3JhY2xlIExBRCBUZWNoIENsb3VkIEluYzEXMBUG
A1UEAwwOKi5vZXhhbXBsZS5jb20xHjAcBgkqhkiG9w0BCQEWD2NhQG9leGFtcGxl
LmNvbTAeFw0yMzExMTQwMzA1MTNaFw0yMzEyMTQwMzA1MTNaMIHEMQswCQYDVQQG
EwJNWDEZMBcGA1UECAwQQ2l1ZGFkIGRlIE1leGljbzEZMBcGA1UEBwwQQ2l1ZGFk
IGRlIE1leGljbzEaMBgGA1UECgwRU1NMIENBIFJlY29nbml6ZWQxKjAoBgNVBAsM
IUV4YW1wbGUgT3JhY2xlIExBRCBUZWNoIENsb3VkIEluYzEXMBUGA1UEAwwOKi5v
ZXhhbXBsZS5jb20xHjAcBgkqhkiG9w0BCQEWD2NhQG9leGFtcGxlLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANWST8dn0xMi5WPcS8qoubk6bSvk
MdEs+Me6UVbWrQ+hp0MeSJ7Qp5v3hkYJzxXEqfrGz4birsbXp/i+Ycdy/9779Mzv
yRvx6HMyRrqJDvYwdQEgv7ojiI7KfUJqOv7HzR4HiaGag6k39EIguybcuETark3J
UbDpGj4HUJ+XBSbyWk8YQyOlmKwuFZ8ApSVWO6oHodeVVne5oQrQrF9o1Os+fFhm
oEGgYcJgabLjZUUZ/RKYrvXuDcqtzWc7deHjJeyktCcXALwl2OiqUXMneuQgpDkq
UPJI3rwYP+GYHxUQ5P7chnmGtCb0y8jLJlX8MfaSGTAyR8h84hT7UBs9wksCAwEA
ATANBgkqhkiG9w0BAQsFAAOCAQEAI79e7k1QAwn4EFfeS7zYWr1iMH/uyTaYiG+z
PM2y7lyZPgRnWWibfUs7uu6rmn/9fptxdp+1SRzioX6x4T5kZnlJLTL2ELNWyhP/
Xa0uFFpHaB04oRbM6GxLFXr+b+lNUbvDqqm1BpxY0tvKk+ZoQDjl0nIJ1qchoiHQ
H15Bypfh4zWbmgfHwayjEGVF5fvBHq+fF3fFUS492Q00/A+aXP5Ef2yFVO+sQj2Y
NK7bsf+S3BpozHfZ+sEF4v3CyF4UiClENXAI+n3722YTziNw1wLBVz0+oy34R1CW
QAVOsFMtYG74483zgo5VMP1khLStzGkf2JsvLYnzR12PQuvHQA==
-----END CERTIFICATE-----' > /etc/pki/CA/certs/ca.crt

echo '-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAv2fZqu6AEFRZLISLvi6dBO65jXrCRixuud7Ahb45rk7ISmhv
XrMR7ZwzYXXGPqgio+yhK/oeDVEbEvPKMPB7EgPAtEZk6obVP1ifbxwNKO1gdvj1
fw3sorPENaJR0Gotbl8CXnU2fC30i5GlVJt+cbrbmc/mxbAw7QQwOD2k6iEIrcR+
uRCq11ebP6JbNgYFtSt/xImg1Ri6oeVfJA8mxPwox/DgIOjxGWVMQOYek3n3HH81
3tbzXrpN++yUaYyjZ8Ff1o4RIh9C0yrUnUZfqR/qSoRBt3yErf+cEdtkqzlobC84
SB0MOcoLjjZTGuo+xAaZAsqloGZDHi0IQm02gwIDAQABAoIBAQCc03ksLWgueP3r
lNpuxACRZwwPWNLO7l722gVCT98w64n+NV1y6SO6XO5YX0hEVDy1tQ9FWhS/coHN
YIR83rznwL1mt/q9kiYtVe6j+gbqTrxoHon/RShrEwGjtFB2hFifAyeMv1saGgkx
Re+ByDms8540g3yg40DjIjhkDFYQIf/MZopnEMA92X34BYrkHz8NxRBQYqJIAfYQ
K4UEZMMIVJFXEo5MgO8TGrebNBnbgsU2f8JFIEZy9jcSYf9NYramE3q+y1Y/rQcq
xsI/VnY5sM/IQStU9zjTfNFnVwmx2e9D3RF6pGLXFFYdmNL/z6kCSPkJnQnuwBv8
aEcwPQQxAoGBAObO15ppHtcA+tZMYfzHanTbzaSJx6exNePv5on4uDCXNQ7OFu+F
wjfMcuLQPB+ku30qJpeH4IiX7r9+6ifdbcd0p0aTM8wS8RXxLaU53fmf7fjcz/uk
IfiroH2/tjoSdSetF8m7xRBW8speIoyapNj1prPFHBts2XGdBWnEVkl5AoGBANRM
CsaB/2/tS5fKQhN4ORoa559Gs1V1qC3ZZCaJV2S44rFImLMiPK4dqL74IjtPWXk9
Yvl/3Ds1zFpEYrldNo7nN0p3khBCX1QzgjoDvDQhC/Lc/LoutPkRKEExv3r7YRHI
aQ8m710hlIckOvYZ95QqXkI5Kqd0qNVaq5l5hDzbAoGAf9Zy7pBox3dAd6+I2mRt
X1pbNVYm4oexrJU0oJjFFAy8E34sj/ALGbLAs0XY90HbosDU7TsSLzXPw/r8oKXx
ZvcCq4FewBqBs8CIoqpBe0CMozlSbTOEqWIOG3gy60lL4HTr5w18Ycd25IVtJ2mE
ArNU6N806S/J5DavR9y6WikCgYASBT5o6UIAgzkGcnG3a14VfDErEPpKB8m10p0w
tDnJ3/PGLq5fjkluUjAvvapSNIMYyoArQ5IzKHbnNqTWrTXjXXcRCCNK5Adpg1HL
kOOZ3TBBdkaxmyNbfPxYxFtHmiz8MHHSinCJDD+qVQX4O+4LEqmbn3SicEGgkqi8
R1dVPwKBgA2OKshVr/2T8L0YCeBsh0sH72mg8D/yCXGBad6VsaqytmyVKkGLjXFc
5vSVSL+2DBBJ4+swc6ho6PqgArQ3yIT2iMjMnXoRDlJ0uTuHVXNRNCFshnxWr5Yz
mnOmJ0nCFoiH3JJRhmPKzl6yVmDNuDbRIMpQO6ptMPP34gBc29rl
-----END RSA PRIVATE KEY-----' > /etc/pki/tls/private/loadbalancer.key
 
echo '
<VirtualHost *:443>
    DocumentRoot /var/www/html
    ServerName apps.example.com
    SSLEngine on
    SSLCertificateFile /etc/pki/tls/certs/loadbalancer.crt
    SSLCertificateKeyFile /etc/pki/tls/private/loadbalancer.key
    SSLCertificateChainFile /etc/pki/CA/certs/ca.crt
</VirtualHost>' >> /etc/httpd/conf.d/apps-example-com.conf

firewall-offline-cmd --add-service=http --add-service=https
systemctl enable  firewalld
systemctl restart firewalld
systemctl restart httpd

touch ~/opc/userdata.$(date +%s).finish
echo '################### webserver userdata ends #######################'
EOF
}

variable "instance_image_ocid" {
  type = map(string)
  default = {
    # See https://docs.oracle.com/en-us/iaas/images/image/4d8a588e-bb9d-428d-af29-245ec57aa41a/
    # Oracle-provided image "Oracle-Linux-8.6-2022.08.29-0"
    us-phoenix-1   = "ocid1.image.oc1.phx.aaaaaaaa3lzck3xxr3sjm2z3psdeyacwv4buumt26y4zdyrg5dylfgxireta"
    us-ashburn-1   = "ocid1.image.oc1.iad.aaaaaaaasdqmcux7p5sdhhsqygmfzf2n6smemihykfv4bv7qh4235zre75da"
    eu-frankfurt-1 = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaaoffnm7opezqbhzln3u4lzv6ujteag5h7oxcsio3kr35sp7mlamcq"
    sa-santiago-1  = "ocid1.image.oc1.sa-santiago-1.aaaaaaaaq24fasno4jlzuxhwvxkxkbebdmkqestbz65hi4xgm6of5dlmztvq"
    mx-queretaro-1 = "ocid1.image.oc1.mx-queretaro-1.aaaaaaaaphf2lkmclgfoms3r5y6f4ioxi72hdo4r53qaoa2igyelbz4ldp7q"
  }
}
## Certificates variables
# LB-specific variables
variable "lb_options" {
  type = object({
    display_name   = string,
    compartment_id = string,
    shape          = string,
    subnet_ids     = list(string),
    private        = bool,
    nsg_ids        = list(string),
    defined_tags   = map(string),
    freeform_tags  = map(string)
  })
  description = "Parameters for customizing the LB."
  default = {
    display_name   = null
    compartment_id = null
    shape          = null
    subnet_ids     = null
    private        = null
    nsg_ids        = null
    defined_tags   = null
    freeform_tags  = null
  }
}

# Certificates-specific variables
variable "certificates" {
  type = map(object({
    ca_certificate     = string,
    passphrase         = string,
    private_key        = string,
    public_certificate = string,
  }))
  description = "Parameters for Certificates."
  default     = {}
}

# Backend-sets-specific variables
variable "backend_sets" {
  type = map(object({
    policy                  = string,
    health_check_name       = string,
    enable_persistency      = bool,
    cookie_name             = string,
    disable_fallback        = bool,
    enable_ssl              = bool,
    certificate_name        = string,
    verify_depth            = number,
    verify_peer_certificate = bool,
    backends = map(object({
      ip      = string,
      port    = number,
      backup  = bool,
      drain   = bool,
      offline = bool,
      weight  = number
    }))
  }))
  description = "Parameters for Backend Sets."
  default     = {}
}

# Health Check variables
variable "health_checks" {
  type = map(object({
    protocol            = string,
    interval_ms         = number,
    port                = number,
    response_body_regex = string,
    retries             = number,
    return_code         = number,
    timeout_in_millis   = number,
    url_path            = string
  }))
  description = "Parameters for health checks (used by Backend Sets)."
  default     = {}
}

# Path Route Set-specific variables
variable "path_route_sets" {
  type = map(list(object({
    backend_set_name = string,
    path             = string,
    # valid values: EXACT_MATCH, FORCE_LONGEST_PREFIX_MATCH, PREFIX_MATCH, SUFFIX_MATCH
    match_type = string
  })))
  description = "Parameters for Path Route Sets."
  default     = {}
}

# Rule Set-specific variables
variable "rule_sets" {
  type = map(list(object({
    action = string,
    header = string,
    prefix = string,
    suffix = string,
    value  = string
  })))
  description = "Parameters for Rule Sets."
  default     = {}
}

# Listener-specific variables
variable "listeners" {
  type = map(object({
    default_backend_set_name = string,
    port                     = number,
    protocol                 = string,
    idle_timeout             = number,
    hostnames                = list(string),
    path_route_set_name      = string,
    rule_set_names           = list(string),
    enable_ssl               = bool,
    certificate_name         = string,
    verify_depth             = number,
    verify_peer_certificate  = bool
  }))
  description = "Parameters for Listeners."
  default     = {}
}
variable "profile" {
  type = string
  default = "DEFAULT"
  description = "Default profile in OCI-CLI config file (~/.oci/config)"
}

variable "load_balancer_shape_details_maximum_bandwidth_in_mbps" {
  default = 10
}

variable "load_balancer_shape_details_minimum_bandwidth_in_mbps" {
  default = 10
}