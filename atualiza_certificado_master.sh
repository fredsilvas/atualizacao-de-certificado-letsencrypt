#!/bin/sh

DOMINIO='sei.ifpr.edu.br'
PATH_LETSENCRYPT='/etc/letsencrypt/live'
PATH_HAPROXY='/etc/haproxy/cert/letsencrypt_cert'
APP_01=172.16.1.159



#echo "Iniciando renovação de Certificado";
#systemctl stop haproxy
#sleep 5
#certbot renew --quiet


echo "Certificado Renovado, atualizando as configurações do HAPROXY."

# Gerando o arquivo pem para HAPROXY com o certificado
`cat $PATH_LETSENCRYPT/$DOMINIO/fullchain.pem $PATH_LETSENCRYPT/$DOMINIO/privkey.pem > $PATH_HAPROXY/$DOMINIO.pem`
chmod 600 $PATH_HAPROXY/$DOMINIO.pem
cp $PATH_HAPROXY/$DOMINIO.pem LETSENCRYPT/$DOMINIO/$DOMINIO.pem
#systemctl start haproxy


# Copiar os Certificados para as outras maquinas LOADBALANCE (Colocar uma maquina por linha, inserindo a variavel)
`rsync -a /etc/letsencrypt/ $APP_01::letsencrypt_cert 2> /dev/null`