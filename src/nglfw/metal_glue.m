//:________________________________________________________
//  wgpu-nim  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
//:________________________________________________________
// Mac Glue code implementation.       |
// See ./metal_glue.h for more details.  |
//_____________________________________|
#include "./metal_glue.h"
// For getting the CAMetalLayer.
// Seems broken when placed in the header :think:
#include <Foundation/Foundation.h>
#include <QuartzCore/CAMetalLayer.h>

id macGetMetalLayer(GLFWwindow* window) {
  id metal_layer = NULL;
  NSWindow* ns_window = glfwGetCocoaWindow(window);
  [ns_window.contentView setWantsLayer:YES];
  metal_layer = [CAMetalLayer layer];
  [ns_window.contentView setLayer:metal_layer];
  return metal_layer;
}


