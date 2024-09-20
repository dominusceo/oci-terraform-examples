#Autor: Ricardo David Carrillo Sanchez
#Goal: Generate self-signed certificates
certs="./certs/"
openssl genrsa -out ${certs}ca.key 2048
openssl req -config ${certs}OEXAMPLE.cnf -new -key ${certs}ca.key -out ${certs}ca.csr
openssl x509 -req -in ${certs}ca.csr -signkey ${certs}ca.key -out ${certs}ca.crt
openssl genrsa -out ${certs}loadbalancer.key 2048
openssl req -config ${certs}OEXAMPLE.cnf -new -key ${certs}loadbalancer.key -out ${certs}loadbalancer.csr
openssl x509 -req -in ${certs}loadbalancer.csr -CA ${certs}ca.crt -CAkey ${certs}ca.key -CAcreateserial -out ${certs}loadbalancer.crt -days 50000
openssl x509 -in ${certs}loadbalancer.crt -text