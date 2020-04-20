#https://github.com/wardviaene/terraform-demo/blob/master/rds.tf
#https://github.com/Smartling/aws-terraform-workshops/blob/master/answers/w1/ec2.tf

yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y
yum-config-manager --enable remi-php73
yum install httpd epel-release yum-utils git php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd php-xml -y
systemctl enable httpd
mkdir -p /var/www/html/azure_proj/demo/ /var/www/html/azure_proj/src/Imdb/ /mnt/cache/imdb/images
ln -s /mnt/cache/imdb/images/ /var/www/html/azure_proj/demo/images
ln -s /mnt/cache/imdb/ /var/www/html/azure_proj/src/Imdb/cache
