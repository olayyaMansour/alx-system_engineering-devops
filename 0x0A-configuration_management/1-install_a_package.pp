# Puppet manifest to install Flask package using pip3

# Install Flask package using pip3
package { 'flask':
ensure   => '2.1.0',
provider => 'pip3',
}
