#Autor: Ricardo David Carrillo Sanchez
#Goal: Generate self-signed certificates
path_certs="./certs/"
openssl genrsa -out ca.key 2048
openssl req -config ${path_certs}DOMINUSCEO.cnf  -new -key ${path_certs}ca.key -out ${path_certs}ca.csr
openssl x509 -req -in ${path_certs}ca.csr -signkey ${path_certs}ca.key -out ${path_certs}ca.crt
openssl genrsa -out ${path_certs}loadbalancer.key 2048
openssl req -config ${path_certs}DOMINUSCEO.cnf -new -key ${path_certs}loadbalancer.key -out ${path_certs}loadbalancer.csr
openssl x509 -req -in ${path_certs}loadbalancer.csr -CA ${path_certs}ca.crt -CAkey ${path_certs}ca.key -CAcreateserial -out ${path_certs}loadbalancer.crt -days 50000
openssl x509 -in ${path_certs}loadbalancer.crt -text
sleep 50