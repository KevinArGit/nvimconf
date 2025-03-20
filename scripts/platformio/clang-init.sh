#!/usr/bin/env bash

# Create .clangd file
cat <<EOL > .clangd
CompileFlags:                    
  Add:
    [
      # -mlong-calls,
      -DSSIZE_MAX,
      -DLWIP_NO_UNISTD_H=1,
      -Dssize_t=long,
      -D_SSIZE_T_DECLARED,
EOL

# Append -D and -I flags from .ccls to .clangd with proper indentation and commas
grep "^-D" ./.ccls | sed 's/^/      /' | sed 's/$/,/' >> .clangd
grep "^-I" ./.ccls | sed 's/^/      /' | sed 's/$/,/' >> .clangd

# Close the Add section and add the Remove section
cat <<EOL >> .clangd
    ]
  Remove:
    [
      -fno-tree-switch-conversion,
      -mtext-section-literals,
      -mlongcalls,
      -fstrict-volatile-bitfields,
      -free,
      -fipa-pta,
    ]
EOL

# Create .clangd-tidy file
echo "Checks: '-*, -misc-definitions-in-headers' " > .clangd-tidy

# Create gen_compile_commands.py script
cat <<EOL > gen_compile_commands.py
import os
Import("env")

# include toolchain paths
env.Replace(COMPILATIONDB_INCLUDE_TOOLCHAIN=True)

# override compilation DB path
env.Replace(COMPILATIONDB_PATH="compile_commands.json")
EOL

# Append to platformio.ini
echo 'extra_scripts = pre:gen_compile_commands.py' >> platformio.ini
