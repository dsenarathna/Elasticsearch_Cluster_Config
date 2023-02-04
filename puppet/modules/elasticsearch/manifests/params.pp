# Class: elasticsearch::params
#
# This class manages parameters for the elasticsearch module
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class elasticsearch::params {
  $cluster_name = $cluster_name ? {
    ''      => 'graylog2',
    default => $cluster_name
  }

  $heap_size = $heap_size ? {
    ''      => '1G',
    default => $heap_size
  }
}
