//:________________________________________________________
//  wgpu-nim  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
//:________________________________________________________
#if defined __APPLE__

//____________________________
// For the NSWindow and GLFWwindow
#include <GLFW/glfw3.h>
#define GLFW_EXPOSE_NATIVE_COCOA
#include <GLFW/glfw3native.h>

//______________________________________.
// Our glue function.
//____________________________.
/// Creates a CAMetalLayer and returns it.
/// Same method used in wgpu-native/examples.
id macGetMetalLayer(GLFWwindow* window);

//________________________________________________
#else  // not __APPLE__
  #error "This file should only be used on Mac"
#endif // << __APPLE__

