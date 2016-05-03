ansible-role-pkg
================

Configre pkg(8)

Requirements
------------

The hos tmust be FreeBSD.

Role Variables
--------------

| variable | description | default |
|----------|-------------|---------|
| pkg\_conf | path to pkg.conf | /usr/local/etc/pkg.conf |
| pkg\_repos\_dir | path to the directory of repositories | /usr/local/etc/pkg/repos |
| pkg\_sites | dict of sites (see below) | {} |


Dependencies
------------

None

Example Playbook
----------------

    - hosts: all
      roles:
        - ansible-role-pkg
      vars:
        pkg_repos:
          FreeBSD:
            url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest"
            mirror_type: srv
            signature_type: fingerprints
            fingerprints: /usr/share/keys/pkg
            enabled: "no"
          Reallyenglish:
            url: "pkg+http://10.1.build.reallyenglish.com/${ABI}"
            mirror_type: srv
            signature_type: "none"
            fingerprints:
            enabled: "yes"

License
-------

BSD

Author Information
------------------

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
