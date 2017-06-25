path = require('path')
fs = require('fs')

VIRTUAL_ENV_NAME = '.venv'

activateVirtualenv = ->
  project = atom.project.getPaths()[0]
  if project
    virtualenv = path.join(project, VIRTUAL_ENV_NAME)
    fs.lstat(virtualenv, (err, stats) ->
      if not err and stats.isDirectory()
        virtualenv_bin = path.join(virtualenv, 'bin')
        process.env.PATH = [virtualenv_bin, process.env.PATH].join ':'
        process.env.VIRTUAL_ENV = virtualenv
        console.log("Activated virtualenv at #{virtualenv}")
    )

activateVirtualenv()

process.env.PYTHONIOENCODING = 'utf_8'
process.env.PYTHONDONTWRITEBYTECODE = '1'
process.env.PYTHONUNBUFFERED = '1'
