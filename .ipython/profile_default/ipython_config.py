# Configuration file for ipython.

c = get_config()

c.InteractiveShellApp.exec_PYTHONSTARTUP = True

c.TerminalIPythonApp.display_banner = False

c.InteractiveShell.automagic = True
c.TerminalInteractiveShell.confirm_exit = False

c.TerminalInteractiveShell.highlighting_style = 'native'

c.TerminalInteractiveShell.term_title = False
c.TerminalInteractiveShell.true_color = False


c.InteractiveShellApp.exec_lines = [
    '%load_ext autoreload',
    '%autoreload 2',
]
