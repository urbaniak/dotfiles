#!/usr/bin/env python
# -*- coding: utf-8 -*-

from fabric.api import prompt
from os.path import abspath, dirname, exists, expanduser, join
from os import symlink, walk, remove
from shutil import rmtree


DOTFILES_DIR = dirname(abspath(__file__))


def install():
	for top, directories, files in walk(DOTFILES_DIR):
		for fn in files:
			if not fn.endswith('.symlink'):
				continue

			fname = join(top, fn)

			src = abspath(fname)
			dst = expanduser('~') + fname.replace('.symlink', '').replace(DOTFILES_DIR, '')

			if exists(dst):
				r = prompt('File %s already exists. Overwrite?' % dst, default='n')

				if r == 'n':
					continue
				elif r == 'y':
					try:
						remove(dst)
					except OSError:
						rmtree(dst)

			symlink(src, dst)
