# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

regionStartParenPattern = /^[\(]$/

getCursorPositionToTheRight = (editor) ->
  cursor = editor.getLastCursor()
  cursor.moveRight()
  pos = editor.getCursorBufferPosition()
  cursor.moveLeft()
  return pos

getCursorPositionToTheLeft = (editor) ->
  cursor = editor.getLastCursor()
  cursor.moveLeft()
  pos = editor.getCursorBufferPosition()
  cursor.moveRight()
  return pos

moveToNextSuperColliderRegion = (editor) ->
  buf = editor.getBuffer()
  searchStartPos = getCursorPositionToTheRight(editor)

  buf.scanInRange(regionStartParenPattern, [searchStartPos, buf.getEndPosition()], (object) ->
    editor.setCursorBufferPosition(object.range.start)
    object.stop()
  )

moveToPreviousSuperColliderRegion = (editor) ->
  buf = editor.getBuffer()
  cursor = editor.getLastCursor()
  searchEndPos = getCursorPositionToTheLeft(editor)

  buf.backwardsScanInRange(regionStartParenPattern, [buf.getFirstPosition(), searchEndPos], (object) ->
    editor.setCursorBufferPosition(object.range.start)
    object.stop()
  )

selectSuperColliderRegion = (editor) ->
  return unless range = getCurrentSuperColliderRegion(editor)
  editor.setSelectedBufferRange(range)

getCurrentSuperColliderRegion = (editor) ->
  if editor.getSelectedText() == ""
    regionParenPattern = /^[\(\)]$/

    buf = editor.getBuffer()
    currentBufferPosition = editor.getCursorBufferPosition()
    lineText = editor.lineTextForBufferRow(currentBufferPosition.row)
    pos = if lineText == "("
      getCursorPositionToTheRight(editor)
    else if lineText == ")"
      getCursorPositionToTheLeft(editor)
    else
      currentBufferPosition

    console.log(pos)

    firstParenPos = null
    secondParenPos = null
    buf.backwardsScanInRange(regionParenPattern, [[0, 0], pos], (object) ->
      if object.match[0] == "("
        firstParenPos = object.range.start
        object.stop()
        buf.scanInRange(regionParenPattern, [pos, buf.getEndPosition()], (object) ->
          if object.match[0] == ")"
            secondParenPos = object.range.end
            object.stop()
        )
    )
    if (firstParenPos != null) and (secondParenPos != null)
      return [firstParenPos, secondParenPos]
    else
      return null

atom.commands.add 'atom-text-editor', 'supercollider:open-startup-file', ->
  atom.workspace.open("C:\\Users\\ahorse\\AppData\\Local\\SuperCollider\\startup.scd")

atom.commands.add 'atom-text-editor', 'supercollider:move-to-next-region', ->
  return unless editor = atom.workspace.getActiveTextEditor()
  moveToNextSuperColliderRegion(editor)

atom.commands.add 'atom-text-editor', 'supercollider:move-to-previous-region', ->
  return unless editor = atom.workspace.getActiveTextEditor()
  moveToPreviousSuperColliderRegion(editor)

atom.commands.add 'atom-text-editor', 'supercollider:evaluate-line-selection-or-region', ->
  return unless editor = atom.workspace.getActiveTextEditor()
  currentPos = editor.getCursorBufferPosition()
  selectSuperColliderRegion(editor)
  atom.commands.dispatch(atom.views.getView(editor), 'supercollider:eval')
  editor.setCursorBufferPosition(currentPos)
