#!/usr/bin/env python3
import os
import subprocess


def sbuild(pkg):
    subprocess.check_call(['sbuild', pkg])


def find_changes(pkg):
    ls = os.listdir('.')
    pklist = [f for f in ls if f.startswith(pkg)]
    changes = [f for f in pklist if f.endswith(".changes")]
    return changes


def dput(pkg, basedir="/vagrant/extra/repo"):
    changes = find_changes(pkg)
    if len(changes) != 1:
        raise RuntimeError("bad number of .changes {}".format(changes))
    changes = changes.pop()
    cmd = ['reprepro', '-b', basedir, 'include', 'stretch',
           changes]
    subprocess.check_call(cmd)


packages = ['sphinx-celery', 'case', 'vine', 'python-amqp',
            'kombu', 'billiard', 'celery', 'redis']

for package in packages:
    changes = find_changes(package)
    if not len(changes):
        sbuild(package)
        dput(package)
