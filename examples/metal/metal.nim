{.
  passC: "-D_GLFW_COCOA",
  passL: "-framework Cocoa -framework OpenGL -framework Metal -framework QuartzCore",
  compile: "metal.m",
.}
import staticglfw

proc main2(): cint {.importc.}

echo "here"
discard main2()
echo "bye"
