# Puppet manifest to install and configure Nginx web server

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx service
service { 'nginx':
  ensure => running,
  enable => true,
  require => Package['nginx'],
}

# Nginx default page template
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Nginx server configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Nginx default server listens on port 80
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Ensure Nginx returns "Hello World!" at root /
file_line { 'nginx_default_content':
  ensure  => present,
  path    => '/etc/nginx/sites-available/default',
  line    => '        root /var/www/html;',
  require => File['/etc/nginx/sites-available/default'],
  notify  => Service['nginx'],
}

# Redirect configuration
file { '/etc/nginx/sites-available/redirect':
  ensure  => file,
  content => template('nginx/redirect.erb'),
  notify  => Service['nginx'],
}

# Symbolic link to enable the redirect
file { '/etc/nginx/sites-enabled/redirect':
  ensure => link,
  target => '/etc/nginx/sites-available/redirect',
  notify => Service['nginx'],
}

# Restart Nginx when the default config or redirect config changes
exec { 'restart_nginx':
  command     => '/usr/sbin/service nginx restart',
  refreshonly => true,
  subscribe   => [
    File['/etc/nginx/sites-available/default'],
    File['/etc/nginx/sites-available/redirect'],
  ],
}
