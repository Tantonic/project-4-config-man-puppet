#NGINX
package { 'nginx':
  ensure => installed,
}

service { 'nginx':
  ensure  => true,
  enable  => true,
  require => Package['nginx'],
}

#PHP
exec { 'php install':
  command => "sudo apt install php7.2 php7.2-gd php7.2-mysql php7.2-zip php7.2-fpm -y",
  path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  cwd     => '/home/ubuntu/'
}

#MYSQL
include mysql::server

mysql::db { 'mydb':
  user     => 'wpuser',
  password => 'admin',
  host     => 'localhost',
  grant    => ['ALL PRIVILEGES'],
}

#WORDPRESS
exec { 'wordpress zip download, extract':
  command => "sudo wget https://wordpress.org/latest.zip && unzip latest.zip",
  path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  cwd     => '/home/ubuntu/'
}

exec { 'copy wordpress to /var/www/html/':
  command => "sudo cp -r * /var/www/html/",
  path    => '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin',
  cwd     => '/home/ubuntu/wordpress/'
}
