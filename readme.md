# Static GLFW for Nim
Statically linked GLFW. Its functionality gets included into your binary.  
Removes the need to distribute your own copy of `glfw.dll` / `libglfw3.dylib`.

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
- Added `getMetalLayer` function, for getting a CAMetalLayer pointer on mac (used for `wgpu`)
- Added a pair of `metal_glue.c` and `metal_glue.h` files for Metal related extensions.
- Moved the buildsystem code into its own separate file at nglfw/compile.nim
- Moved treeform's ime implementation into a (TEMP) non-compiled file at nglfw/ime.c
- nglfw/ folder now contains library functionality and extensions
- Removed previous C code from version 3.3.2
```
```md
# Version: 3.3.8.0
- Hello NoAPI Window example (for vulkan and wgpu-native)
- Support for native window creation (wgpu, etc):
- Applied: https://github.com/DanielBelmes/glfw/commit/06e74d271021365ca3582adbfabef74138fb43e1
- Updated to latest glfw version:  3.3.8 from 3.3.2  
- Fork from `staticglfw`
```
```
# Version: 3.3.2
Our fork from `treeform/staticglfw` started at this version  
It was tracking commit:
https://github.com/glfw/glfw/commit/bf1c62b2612dba79365e836830fe2a6105adbe78
```

## Fork Info
Fork of `treeform/staticglfw`, the original is no longer maintained.

