IncludeguardView = require './includeguard-view'
{CompositeDisposable} = require 'atom'

module.exports = Includeguard =
  includeguardView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @includeguardView = new IncludeguardView(state.includeguardViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @includeguardView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'includeguard:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @includeguardView.destroy()

  serialize: ->
    includeguardViewState: @includeguardView.serialize()

  toggle: ->
    console.log 'Include Guard was inserted!'
