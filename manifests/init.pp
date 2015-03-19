# = Class: sysctl
#
# == Requires:
#
# Only tested on RHEL5 and RHEL6
#
# == Sample Usage:
#
#sysctl::set {
#    'kernel.shmall':   value => 2097152;
#    'kernel.shmmax':   value => '2147483648';
#    'kernel.shmmni':   value => '4096';
#    'kernel.sem':      value => '256 32000 100 142';
#    'fs.file-max':     value => '131072';
#    'kernel.msgmni':   value => '2878';
#    'kernel.msgmax':   value => '8192';
#    'kernel.msgmnb':   value => '65535';
#    'net.ipv4.ip_local_port_range': value => '10000 65000';
#}


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
