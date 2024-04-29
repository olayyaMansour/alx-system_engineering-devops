# This Puppet manifest configures HAProxy to add a custom HTTP header

file { '/etc/haproxy/haproxy.cfg':
    ensure => file,
    source => 'puppet:///modules/haproxy/haproxy.cfg',
    notify => Service['haproxy'],
}

service { 'haproxy':
    ensure => running,
    enable => true,
}
