#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function

from os.path import abspath, dirname, lexists, expanduser, join, islink
from os import symlink, walk, remove, makedirs, unlink
from shutil import rmtree


DOTFILES_DIR = dirname(abspath(__file__))


for top, directories, files in walk(DOTFILES_DIR):
    for fn in files:
        src = abspath(join(top, fn))
        dst = join(expanduser('~'), src.replace(DOTFILES_DIR, '').lstrip('/'))

        if '/.git/' in src or src.endswith('install.py'):
            continue

        if '/' in dst:
            try:
                makedirs('/'.join(dst.split('/')[:-1]))
            except OSError:
                pass

        if lexists(dst):
            r = raw_input('File %s already exists. Overwrite? ' % dst)

            if r.lower().strip() == 'y':
                if islink(dst):
                    unlink(dst)
                else:
                    remove(dst)
            else:
                continue

        print('Making symlink %s' % dst)
        symlink(src, dst)
