# Ensures the sysctl key is set to value

define sysctl::set($value, $key = $name) {

    include sysctl

    # Ensure the key is clean (i.e., not set multiple times)
    augeas { "sysctl-${key}-clean":
        context => '/files/etc/sysctl.conf',
        changes => "rm ${key}",
        onlyif  => "match ${key} size > 1",
        notify  => Exec['sysctl_refresh'],
        before  => Augeas["sysctl-${key}-set"],
    }

    # Set the key
    augeas { "sysctl-${key}-set":
        context => '/files/etc/sysctl.conf',
        changes => "set ${key} '${value}'",
        onlyif  => "get ${key} != '${value}'",
        notify  => Exec['sysctl_refresh']
    }
}

