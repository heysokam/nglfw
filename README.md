# Static GLFW for nim

This library is always statically linked so only the functionality you use gets included in the binary. There is also no need for glfw.dll or libglfw3.dylib to be included.

## Example

```nim
import staticglfw
import opengl

# Init GLFW
if init() == 0:
  raise newException(Exception, "Failed to Initialize GLFW")

# Open window.
var window = createWindow(800, 600, "GLFW3 WINDOW", nil, nil)
# Connect the GL context.
window.makeContextCurrent()
# This must be called to make any GL function work
loadExtensions()

# Run while window is open.
while windowShouldClose(window) == 0:

  # Draw red color screen.
  glClearColor(1, 0, 0, 1)
  glClear(GL_COLOR_BUFFER_BIT)

  # Swap buffers (this will display the red color)
  window.swapBuffers()

  # Check for events.
  pollEvents()
  # If you get ESC key quit.
  if window.getKey(KEY_ESCAPE) == 1:
    window.setWindowShouldClose(1)

# Destroy the window.
window.destroyWindow()
# Exit GLFW.
terminate()
```

## GLFW version:

Version: 3.3.2

Currently tracking this commit: https://github.com/glfw/glfw/commit/bf1c62b2612dba79365e836830fe2a6105adbe78
