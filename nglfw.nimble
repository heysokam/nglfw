#:_____________________________________________________
#  nglfw  |  Copyright (C) Ivan Mar (sOkam!)  |  MIT  |
#:_____________________________________________________

# Package Info
packageName = "nglfw"
version     = "3.3.8.2"  # First three are kept in sync with glfw version
author      = "Ivan Mar (sOkam!)"
description = "Nim GLFW3"
license     = "MIT"

# Folders
srcDir = "src"
binDir = "bin"

# Build requirements
requires "nim >= 1.0.2"

#_________________________________________________
# Tasks: Internal
#___________________
import std/strformat
task push, "Internal:  Pushes the git repository, and orders to create a new git tag for the package, using the latest version.":
  ## Does nothing when local and remote versions are the same.
  requires "https://github.com/beef331/graffiti.git"
  exec "git push"  # Requires local auth
  exec &"graffiti ./{packageName}.nimble"

