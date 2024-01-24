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

> See the [relevant section](#why-i-changed-pure-nim-to-be-my-auxiliary-programming-language-instead-of-being-my-primary-focus) for an explaination of why this is the case.

---

### Why I changed Pure Nim to be my auxiliary programming language, instead of being my primary focus
> _Important:_  
> _This reason is very personal, and it is exclusively about using Nim in a manual-memory-management context._  
> _Nim is great as it is, and the GC performance is so optimized that it's barely noticeable that it is there._  
> _That's why I still think Nim is the best language for projects where a GC'ed workflow makes more sense._  

Nim with `--mm:none` was always my ideal language.  
But its clear that the GC:none feature (albeit niche) is only provided as a sidekick, and not really maintained as a core feature.  

I tried to get Nim to behave correctly with `--mm:none` for months and months.  
It takes an absurd amount of unnecessary effort to get it to a basic default state.  

And I'm not talking about the lack of GC removing half of the nim/std library because of nim's extensive use of seq/string in its stdlib.  
I'm talking about features that shouldn't even be allowed to exist at all in a gc:none context, because they leak memory and create untrackable bugs.  
_(eg: exceptions, object variants, dynamically allocated types, etc etc)_  

After all of that effort, and seeing how futile it was, I gave up on `--mm:none` completely.  
It would take a big amount of effort patching nim itself so that these issues are no longer there.  
And, sadly, based on experience, I'm not confident in my ability to communicate with Nim's leadership to do such work myself.  

This setback led me to consider other alternatives, including Zig or Pure C.  
But, in the end, I decided that from now on I will be programming with my [MinC](https://github.com/heysokam/minc) source-to-source language/compiler instead.  

As such, I will be deprecating most of my `n*dk` libraries.  
I will be creating my engine's devkit with MinC instead.  

That means, as it is detailed in the [Low Maintainance](#low-maintainance-mode) section, that this library will receive a very low/minimal amount of support.

