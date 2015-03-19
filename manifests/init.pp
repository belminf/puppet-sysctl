# = Class: sysctl
#
# == Requires:
#
# Only tested on RHEL5 and RHEL6
#
# == Sample Usage:
#
# class { 'sysctl': }

class sysctl {

    file { '/etc/sysctl.conf':
        ensure => present,
    }

    exec { 'sysctl_refresh':
        command     => '/sbin/sysctl -p',
        refreshonly => true,
        subscribe   => File['/etc/sysctl.conf'],
    }

}
