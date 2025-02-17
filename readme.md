> **Warning**:  
> _This library is in **Low Maintainance** mode._  
> _See the [relevant section](#low-maintainance-mode) for an explanation of what that means._  

![nglfw](./res/gh_banner.png)
# Static GLFW for Nim
GLFW is an Open Source, multi-platform library for OpenGL, OpenGL ES, Vulkan and WebGPU-native application development.  
It provides a simple, platform-independent API for creating windows, contexts and surfaces, reading input, handling events, etc.  
Natively supports Windows, macOS and Linux and other Unix-like systems. On Linux, both X11 and Wayland are supported.

This wrapper is Statically Linked:  
Its functionality gets included into your binary.  
Removes the need to distribute your own copy of `glfw.dll` / `libglfw3.dylib`, etc.  

## How to
```nim
import nglfw as glfw
init()       # init glfw, if no other init function name clashes with it
glfw.init()  # or qualify it to avoid name clashes
# ... etcetera. See examples
```
Alternatively, you can force access imports from the library to be qualified mandatory.  
```nim
# Import all symbols, but they -must- be prefixed to be accessed.
from nglfw as glfw import nil
glfw.init()  # OK
init()       # : Our nglfw init() proc will not be found
```
This avoids conflicts with types, such as when you also have an `import vulkan` in your project.  

## Examples
See [examples/helloclear](./examples/helloclear_OpenGL.nim) for a simple clear-window example using OpenGL  
See [examples/helloNoAPI](./examples/hellowindow_NoAPI.nim) for a simple window creation example without using an API  

## Dependencies
Nim and [whatever dependencies](https://www.glfw.org/docs/latest/compile_guide.html) GLFW requires to be statically compiled on your system.  
In short, just nim and xorg development packages.  

## Optional: Dynamic Linking
Optional: dynamic linking support  (currently untested)  
Do not include `nglfw/compile.nim`, by doing:  
```nim
import nglfw/core as glfw
```


## TODO:
- [ ] Support for raw mouse input.
- [ ] Fix crashing on `-d:danger`.
- [ ] Test dynamic linking with the current setup
- [ ] Finish porting todo.h


## PatchNotes:
```md
# Version: 3.3.8.1
- chg: setWindowShouldClose now takes a bool, instead of a cint
- chg: windowShouldClose() now returns bool instead of cint
- new: Added `getMetalLayer` function, for getting a CAMetalLayer pointer on mac (used for `wgpu`)
- new: Added a pair of `metal_glue.c` and `metal_glue.h` files for Metal related extensions.
- fmt: Moved the buildsystem code into its own separate file at nglfw/compile.nim
- fmt: Moved treeform's ime implementation into a (TEMP) non-compiled file at nglfw/ime.c
- fmt: nglfw/ folder now contains library functionality and extensions
- rmv: Removed previous C code from version 3.3.2
```
```md
# Version: 3.3.8.0
- new: Hello NoAPI Window example (for vulkan and wgpu-native)
- new: Support for native window creation (wgpu, etc):
- chg: Applied: https://github.com/DanielBelmes/glfw/commit/06e74d271021365ca3582adbfabef74138fb43e1
- chg: Updated to latest glfw version:  3.3.8 from 3.3.2  
- git: Fork from `staticglfw`
```
```
# Version: 3.3.2
Our fork from `treeform/staticglfw` started at this version  
It was tracking commit:
https://github.com/glfw/glfw/commit/bf1c62b2612dba79365e836830fe2a6105adbe78
```

## Fork Info
Fork of `treeform/staticglfw`, the original is no longer maintained.


## Low Maintainance mode
This library is in low maintainance mode.  

New GLFW updates are unlikely to be implemented, unless:
- They are randomnly needed for some casual side project _(eg: a gamejam or similar)_  
- They are submitted through a PR  

Proposals and PRs are very welcomed, and are very likely to be accepted right away.  

