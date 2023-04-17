# Static GLFW for Nim
Statically linked GLFW. Its functionality gets included into your binary.  
Removes the need for distributing your own copy of glfw.dll / libglfw3.dylib.

Fork of `treeform/staticglfw`, the original is no longer maintained.

TODO:
- [ ] Support for raw mouse input.
- [ ] Fix crashing on `-d:danger`.
- [ ] Mini-framebuffer example.

Added:
- [x] Support for native window creation (wgpu, etc):
- [x] Hello Window example, (NoAPI: for vulkan and wgpu-native)
- [x] Upgrade
  - [x] Apply: https://github.com/DanielBelmes/glfw/commit/06e74d271021365ca3582adbfabef74138fb43e1
  - [x] Update to latest (3.3.8)

## Example

```nim
import nglfw
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
Currently tracking: https://github.com/glfw/glfw/commit/bf1c62b2612dba79365e836830fe2a6105adbe78
