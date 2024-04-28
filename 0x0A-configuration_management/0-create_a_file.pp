# Puppet manifest to create a file in /tmp

# Define file resource
file { '/tmp/school':
  ensure  => file,      # Ensure it's a file
  mode    => '0744',    # Set file permissions
  owner   => 'www-data',# Set file owner
  group   => 'www-data',# Set file group
  content => "I love Puppet\n",  # Set file content
}
