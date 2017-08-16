# ansible-role-pkg

Configure pkg(8)

# Requirements

The hos tmust be FreeBSD.

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `pkg_conf` | | `/usr/local/etc/pkg.conf` |
| `pkg_repos_dir` | | `/usr/local/etc/pkg/repos` |
| `pkg_sites` | | `{}` |

# Dependencies

None

# Example Playbook

```
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
        url: "http://{{ ansible_distribution_version }}.build.reallyenglish.com/${ABI}"
        mirror_type: http
        signature_type: "none"
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
