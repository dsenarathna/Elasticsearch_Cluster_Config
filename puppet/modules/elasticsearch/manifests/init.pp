# Class: elasticsearch
#
# This class installs and manages the elasticsearch daemon
#
# Parameters:
#
# Actions:
#   - Install elasticsearch
#   - Manage elasticsearch service
#
# Requires:
#   - The java::jdk7 module
#
# Sample Usage:
#
class elasticsearch (
  $cluster_name = $elasticsearch::params::cluster_name,
  $heap_size    = $elasticsearch::params::heap_size,
) {

if ( $::lsbdistcodename == 'jessie' ) {  
    require java::jdk8
    $elasticsearch_ss_dev_hosts = hiera('elasticsearch_ss_dev_hosts')
    
    file {
      '/etc/default/elasticsearch':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['elasticsearch'],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/default/elasticsearch");
      '/etc/elasticsearch':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755';
      '/etc/elasticsearch/elasticsearch.yml':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/elasticsearch/elasticsearch.yml.v2"),
        notify  => Service['elasticsearch'];
    }
  } else {
    require java::jdk7

    file {
      '/etc/default/elasticsearch':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        notify  => Service['elasticsearch'],
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/default/elasticsearch");
      '/etc/elasticsearch':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755';
      '/etc/elasticsearch/elasticsearch.yml':
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${::puppet_dir_master}/systems/_LINUX_/etc/elasticsearch/elasticsearch.yml"),
        notify  => Service['elasticsearch'];
    }
  }

  package {
    'elasticsearch':
      ensure => installed;
  }

  service {
    'elasticsearch':
      ensure     => running,
      enable     => true,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['elasticsearch'];
  }

}
