# Opens a window and quickly exists.
from nglfw as glfw import nil

# Init GLFW
if not glfw.init(): raise newException(Exception, "Failed to Initialize GLFW")

# Open window.
var window = glfw.createWindow(800, 600, "GLFW3 WINDOW", nil, nil)
# Connect the GL context.
glfw.makeContextCurrent(window)

# Swap buffers (this will display the red color)
glfw.swapBuffers(window)

# Check for events.
glfw.pollEvents()
# If you get ESC key quit.
if glfw.getKey(window, glfw.KeyEscape) == 1:
  glfw.setWindowShouldClose(window, true)

# Destroy the window.
glfw.destroyWindow(window)
# Exit GLFW.
glfw.terminate()
