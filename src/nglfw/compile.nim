#:_____________________________________________________
#  nglfw  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
#:_____________________________________________________
# Buildsystem of the library  |
#_____________________________|
import std/os
import std/strformat

const thisDir  = currentSourcePath().parentDir()
const rootDir  = thisDir/".."
const glfwDir  = rootDir/"glfw"/"include"
const nglfwDir = rootDir/"nglfw"

when defined(emscripten):
  {.passL: "-s USE_WEBGL2=1 -s USE_GLFW=3".}
else:
  when defined(windows):
    when defined(gcc):
      {.passC: "-D_GLFW_WIN32", passL: "-lgdi32".}
    when defined(vcc):
      {.passC: "-D_GLFW_WIN32".}
      {.link: "kernel32.lib".}
      {.link: "gdi32.lib".}
      {.link: "shell32.lib".}
      {.link: "user32.lib".}
    {.
      compile: "glfw/src/win32_init.c",
      compile: "glfw/src/win32_joystick.c",
      compile: "glfw/src/win32_module.c",
      compile: "glfw/src/win32_monitor.c",
      compile: "glfw/src/win32_time.c",
      compile: "glfw/src/win32_thread.c",
      compile: "glfw/src/win32_window.c",
      compile: "glfw/src/wgl_context.c",
    .}
    when defined(wgpu): {.passC: "-DGLFW_EXPOSE_NATIVE_WIN32".}
  elif defined(macosx):
    {.
      passC:   "-D_GLFW_COCOA",
      passL:   "-framework Cocoa -framework OpenGL -framework IOKit -framework CoreFoundation",
      compile: "glfw/src/cocoa_init.m",
      compile: "glfw/src/cocoa_joystick.m",
      compile: "glfw/src/cocoa_monitor.m",
      compile: "glfw/src/cocoa_time.c",
      compile: "glfw/src/cocoa_window.m",
      compile: "glfw/src/posix_module.c",
      compile: "glfw/src/posix_thread.c",
      compile: "glfw/src/nsgl_context.m",
    .}
    when defined(wgpu):
      {.
        passC:   "-DGLFW_EXPOSE_NATIVE_COCOA", # Expose native cocoa functions
        passC:   &"-I{glfwDir}",               # Include glfw header folder so our metal_glue file can access it
        passC:   &"-I{nglfwDir}",              # Include nglfw/ for the metal_glue.h file
        # Compile the metal glue file
        compile: ("nglfw/metal_glue.m", "-framework Metal -framework CoreVideo -framework QuartzCore"),
        passL:   "metal_glue.m.o",  # Manually link to the metal_glue.o file
      .}
  elif defined(linux):
    {.passL: "-pthread -lGL -lX11 -lXrandr -lXxf86vm -lXi -lXcursor -lm -lXinerama".}

    when defined(wayland):
      {.
        passC: "-D_GLFW_WAYLAND",
        compile: "glfw/src/wl_init.c",
        compile: "glfw/src/wl_monitor.c",
        compile: "glfw/src/wl_window.c",
        compile: "glfw/src/posix_module.c",
        compile: "glfw/src/posix_poll.c",
        compile: "glfw/src/posix_thread.c",
        compile: "glfw/src/posix_time.c",
        compile: "glfw/src/xkb_unicode.c",
      .}
      when defined(wgpu): {.passC: "-DGLFW_EXPOSE_NATIVE_WAYLAND".}
    else:
      {.
        passC: "-D_GLFW_X11",
        compile: "glfw/src/x11_init.c",
        compile: "glfw/src/x11_monitor.c",
        compile: "glfw/src/x11_window.c",
        compile: "glfw/src/xkb_unicode.c",
        compile: "glfw/src/posix_module.c",
        compile: "glfw/src/posix_poll.c",
        compile: "glfw/src/posix_thread.c",
        compile: "glfw/src/posix_time.c",
        compile: "glfw/src/glx_context.c",
      .}
      when defined(wgpu): {.passC: "-DGLFW_EXPOSE_NATIVE_X11".}

    {.compile: "glfw/src/linux_joystick.c".}
  else:
    # If unsupported/unknown OS, use null system
    {.
      compile: "glfw/src/posix_module.c",
      compile: "glfw/src/posix_poll.c",
      compile: "glfw/src/posix_thread.c",
      compile: "glfw/src/posix_time.c",
    .}

  # Common
  {.
    compile: "glfw/src/context.c",
    compile: "glfw/src/init.c",
    compile: "glfw/src/input.c",
    compile: "glfw/src/monitor.c",
    compile: "glfw/src/platform.c",
    compile: "glfw/src/vulkan.c",
    compile: "glfw/src/window.c"
    # The time, thread and module code is shared between all backends on a given OS,
    # including the null backend, which still needs those bits to be functional
    compile: "glfw/src/null_init.c",
    compile: "glfw/src/null_joystick.c",
    compile: "glfw/src/null_monitor.c",
    compile: "glfw/src/null_window.c",
    compile: "glfw/src/egl_context.c",
    compile: "glfw/src/osmesa_context.c"
  .}

