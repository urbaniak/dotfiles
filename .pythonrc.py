#!/usr/bin/env python
# based on https://github.com/dcramer/dotfiles/blob/master/python/pythonrc.py

import atexit
import os
import readline
import rlcompleter

if 'libedit' in readline.__doc__:
    readline.parse_and_bind("bind ^I rl_complete")
else:
    readline.parse_and_bind("tab: complete")

history = os.path.expanduser("~/.pythonhist")


def save_history(history=history):
    import readline
    readline.write_history_file(history)


if os.path.exists(history):
    try:
        readline.read_history_file(history)
    except IOError:
        pass


atexit.register(save_history)
del os, atexit, readline, rlcompleter, save_history, history
