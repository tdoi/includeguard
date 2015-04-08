{CompositeDisposable} = require 'atom'

module.exports =
  commands: null

  activate: ->
    @commands = new CompositeDisposable
    @commands.add atom.commands.add 'atom-workspace',
      'includeguard:insert': => @insert()

  deactivate: ->
    @commands.dispose()

  insert: ->
    if editor = atom.workspace.getActiveTextEditor()
      filename = @getFilename(editor.getPath())
      id = '__' + filename.replace('.', '_').toUpperCase() + '__'
      buffer = "#pragma once \n" \
        + "#ifndef" + id + "\n" \
        + "#define" + id + "\n" \
        + "\n" \
        + editor.getText() \
        + "\n" \
        + "#endif" + "\n"
      editor.setText(buffer)

  getFilename:(path) ->
    items = path.split("/")
    items[items.length - 1]
