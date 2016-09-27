#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Ansible Module for generating Django Secret Keys
"""
import datetime
from ansible.module_utils.basic import AnsibleModule
from random import choice


DOCUMENTATION = """
---
module: keygen
short_description: Generates a key for use in Django or anyone needing a secret key
description:
     - Uses Python's random module to generate a secret key for use in webapps
       such as Django.
options:
  keylength:
    description:
      - number of characters the generated key should contain
    required: true
    default: 50
  keyspace:
    description:
      - a string containing characters to choose from when generating the key
    required: true
    default: abcdefghijklmnopqrstuvwxyz0123456789
author:
    - Dave Voutila
# ... snip ...
"""

EXAMPLES = """
- action: keygen keylength=50 keyspace=abcdefghijklmnopqrstuvwxyz0123456789

"""

RETURN = """
secret_key:
    description: the secret key generated
    returned: success
    type: string
    sample: "0yfoh8j50ye9fyo37az7epzulx6dbypvo29giicn0j9ev6n7za"
"""

VALID_CHARACTERS = 'abcdefghijklmnopqrstuvwxyz0123456789'


def generate_key(length, choices):
    """ Generate the key! """
    return ''.join([choice(choices) for i in range(length)])


def main():
    module = AnsibleModule(
        argument_spec = dict(
            keylength = dict(aliases=['length'], default='50', type='int'),
            keyspace  = dict(default=VALID_CHARACTERS, type='str')
        )
    )

    length = module.params['keylength']
    keyspace = module.params['keyspace']

    startd = datetime.datetime.now()
    key = generate_key(length, keyspace)
    endd = datetime.datetime.now()
    delta = endd - startd

    module.exit_json(
            secret_key = str(key),
            start    = str(startd),
            end      = str(endd),
            delta    = str(delta),
            changed  = True,
        )

if __name__ == '__main__':
    main()
