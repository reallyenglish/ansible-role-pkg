# ansible-role-pkg

Configure pkg(8)

# Requirements

The hos tmust be FreeBSD.

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `pkg_conf` | path to `pkg.conf(5)` | `/usr/local/etc/pkg.conf` |
| `pkg_config` | dict of `pkg.conf(5)`, which is expanded as JSON | `{}` |
| `pkg_repos_dir` | path to repository directory | `/usr/local/etc/pkg/repos` |
| `pkg_sites` | per site config of `pkg.conf(5)` in dict, which is expanded as JSON | `{}` |

# Dependencies

None

# Example Playbook

```
- hosts: all
  roles:
    - ansible-role-pkg
  vars:
    pkg_config:
      FETCH_TIMEOUT: 300
      FETCH_RETRY: 5
      SYSLOG: "true"
      REPOS_DIR:
        - /etc/pkg/
        - /usr/local/etc/pkg/repos/
    pkg_repos:
      FreeBSD:
        url: "pkg+http://pkg.FreeBSD.org/${ABI}/latest"
        mirror_type: srv
        signature_type: fingerprints
        fingerprints: /usr/share/keys/pkg
        enabled: "no"
      Reallyenglish:
        url: "http://{{ ansible_distribution_version }}.build.reallyenglish.com/${ABI}"
        mirror_type: http
        signature_type: 'none'
        fingerprints:
        enabled: "yes"
```

# License

```
Copyright (c) 2017 Tomoyuki Sakurai <tomoyukis@reallyenglish.com>

Permission to use, copy, modify, and distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
```

# Author Information

Tomoyuki Sakurai <tomoyukis@reallyenglish.com>
