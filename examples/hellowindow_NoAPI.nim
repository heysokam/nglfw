#:_____________________________________________________
#  nglfw  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
#:_____________________________________________________
# Simplest possible window creation with no API.  |
# Useful for running Vulkan and WebGPU apps.      |
#_________________________________________________|
# External dependencies
from pkg/nglfw as glfw import nil

#________________________________________________
# window.nim
#__________________
proc key (win :glfw.Window; key, code, action, mods :cint) :void {.cdecl.}=
  ## GLFW Keyboard Input Callback
  if (key == glfw.KEY_ESCAPE and action == glfw.PRESS):
    glfw.setWindowShouldClose(win, true.cint)
  if action == glfw.PRESS: echo "Pressed key | id:",$key, " code:",$code
#__________________
proc close  (win :glfw.Window) :bool=  glfw.windowShouldClose(win).bool
  ## Returns true when the GLFW window has been marked to be closed.
proc term   (win :glfw.Window) :void=  glfw.destroyWindow(win); glfw.terminate()
  ## Terminates the GLFW window.
proc update (win :glfw.Window) :void=  glfw.pollEvents()
  ## Updates the window. Needs to be called each frame.
#__________________
proc init () :glfw.Window=
  ## Initializes the window with GLFW.
  doAssert glfw.init().bool, "Failed to Initialize GLFW"
  glfw.windowHint(glfw.CLIENT_API, glfw.NO_API)
  result = glfw.createWindow(960, 540, "nglfw | Hello Window NoAPI", nil, nil)
  doAssert result != nil, "Failed to create GLFW window"
  discard glfw.setKeyCallback(result, key)

#________________________________________________
# Entry Point
#__________________
proc run=
  echo "Hello nglfw | No API\nPress Escape to close the window.\nPress any key to see its id/code values."
  var window = init()
  while not window.close():
    window.update()
  window.term()
#__________________
when isMainModule: run()

