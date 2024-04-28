# Puppet manifest to kill a process named killmenow

# Execute pkill command to kill the process
exec { 'killmenow':
  command     => 'pkill -f "killmenow"',
  path        => ['/bin', '/usr/bin', '/sbin', '/usr/sbin'],
  refreshonly => true,  # Execute only when notified
}
