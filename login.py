#!/usr/bin/env python
# -*- coding: utf-8 -*-
# author:  bruce.he

import pexpect

if __name__ == '__main__':
    server = pexpect.spawn('ssh -i /Users/xxx/ec2_server.pem  ec2-user@1.333.333.333')
    server.sendline ('deploy')
    server.sendline ('exit')
    server = pexpect.spawn('ssh -i /Users/xxxx/ec2_server.pem  ec2-user@1.1.333.221')
    server.sendline ('deploy')
    server.sendline ('exit')
    server.interact()     # Give control of the child to the user.
    pass