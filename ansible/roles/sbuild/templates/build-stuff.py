#!/usr/bin/env python3
import os
import subprocess


def sbuild(pkg):
    subprocess.check_call(['sbuild', pkg])


def dput(pkg, basedir="/vagrant/extra/repo"):
    ls = os.listdir('.')
    pklist = [f for f in ls if f.startswith(pkg)]
    changes = [f for f in pklist if f.endswith(".changes")]
    if len(changes) != 1:
        raise RuntimeError("bad number of .changes {}".format(changes))
    changes = changes.pop()
    cmd = ['reprepro', '-b', basedir, 'include', 'stretch',
           changes]
    subprocess.check_call(cmd)


packages = ['sphinx-celery', 'vine', 'python-amqp',
            'case', 'kombu', 'billiard', 'celery']

for package in packages:
    sbuild(package)
    dput(package)
