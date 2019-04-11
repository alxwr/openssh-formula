#!py

import json

def is_salt_ssh():
    return '__master_opts__' in __opts__:

def run():
    if is_salt_ssh():
        data = 
-{%-   load_json as data -%}
-{{      __salt__['cmd.run']("sh -c \"salt --out=json --static salt.srv.tty1.eu mine.get '{}' 'public_ssh_host_keys' 2>/dev/null\"".format(id)) }}
-{%-   endload -%}
-{{    data['salt.srv.tty1.eu'][id] }}
    else
        # https://docs.saltstack.com/en/latest/ref/modules/all/salt.modules.mine.html
        data = __salt__.saltutil.runner('mine.get',
            tgt='*',
            fun='public_ssh_host_keys',
            tgt_type='glob'
        )
    return {'openssh': {'known_hosts': {'mined': data}}}
