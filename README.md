# ansible-role-pkg

Configure pkg(8)

# Requirements

The host must be FreeBSD.

# Role Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `pkg_conf` | path to `pkg.conf(5)` | `/usr/local/etc/pkg.conf` |
| `pkg_config` | dict of `pkg.conf(5)`, which is expanded as JSON | `{}` |
| `pkg_repos_dir` | path to repository directory | `/usr/local/etc/pkg/repos` |
| `pkg_repos` | per site config of `pkg.conf(5)` in dict, which is expanded as JSON | `{}` |
| `pkg_pubkeys` | list of public keys. see below | `[]` |

## `pkg_pubkeys`

This variable is a list of public keys for repositories.

| Key | Description | Mandatory? |
|-----|-------------|------------|
| `path` | path to the key file | yes |
| `state` | either `present` or `absent`. creates the file when `present`, remove the file when `absent` | yes |
| `content` | content of the key file | yes when `state` is `present` |

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
      isc:
        url: "http://pkg0.isc.freebsd.org/${ABI}/latest"
        mirror_type: http
        signature_type: 'none'
        fingerprints:
        enabled: "yes"
    pkg_pubkeys:
      - path: /usr/local/etc/pkg/keys/my.pub
        state: present
        content: |
          -----BEGIN PUBLIC KEY-----
          MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwoMg0XK2SdEaz8b8O6rY
          f+lzDx+ElBXr2ARmFCG+SzKmHf8+zL4+gKMLFv3DytKE2WiZs+WNCKCGYPmH6Sg5
          DOJxpO/NhpqiHSngigB7B2XzZeSCerTiqn4Qw17/ydd1tRFzVS/BPPYyoUnFdZ4+
          xgItaPfa6Ns32mwqUb9mE2EEx66uyU1GAiI7yO1VRYzrHQwyVB74c72mlC/kJaUa
          BLoE9dWfyegRRycRK3sSxMYX0eYE5/EzlmRK3BBLchH57B0u2WWR75MWUfkTWh1p
          AKB/Dxl74fmQT+yvNKk9/U8mo9zVoVw0H7dphgglS2fXXvyFIn9TIVGS5zbe2C4s
          cQIDAQAB
          -----END PUBLIC KEY-----
      - path: /usr/local/etc/pkg/keys/your.pub
        state: present
        content: |
          -----BEGIN PUBLIC KEY-----
          MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwoMg0XK2SdEaz8b8O6rY
          f+lzDx+ElBXr2ARmFCG+SzKmHf8+zL4+gKMLFv3DytKE2WiZs+WNCKCGYPmH6Sg5
          DOJxpO/NhpqiHSngigB7B2XzZeSCerTiqn4Qw17/ydd1tRFzVS/BPPYyoUnFdZ4+
          xgItaPfa6Ns32mwqUb9mE2EEx66uyU1GAiI7yO1VRYzrHQwyVB74c72mlC/kJaUa
          BLoE9dWfyegRRycRK3sSxMYX0eYE5/EzlmRK3BBLchH57B0u2WWR75MWUfkTWh1p
          AKB/Dxl74fmQT+yvNKk9/U8mo9zVoVw0H7dphgglS2fXXvyFIn9TIVGS5zbe2C4s
          cQIDAQAB
          -----END PUBLIC KEY-----
      - path: /usr/local/etc/pkg/keys/none.pub
        state: absent
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
