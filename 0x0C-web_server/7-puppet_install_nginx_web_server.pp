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

# Nginx server configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
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

# Template for Nginx default configuration
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => template('nginx/default.erb'),
  notify  => Service['nginx'],
}

# Nginx default page template
file { '/var/www/html/index.html':
  ensure  => file,
  content => 'Hello World!',
}

# Restart Nginx when the default config or redirect config changes
exec { 'restart_nginx':
  command => '/usr/sbin/service nginx restart',
  refreshonly => true,
  subscribe => [File['/etc/nginx/sites-available/default'], File['/etc/nginx/sites-available/redirect']],
}
