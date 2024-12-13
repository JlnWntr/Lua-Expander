# Lua-Expander
Here’s a Lua script that reads a file, searches for lines containing dofile('file.lua'), and replaces them with the content of the referenced file(s). 
The process is *recursive*, meaning it will also handle dofile calls within the included files.


## Usage:

`$ lua expander.lua your_file.lua optional/directory/`

(The second directory-argument is optional.)

The script prints out all contents. 
If you want to write that output to a file, on Linux/Unix you can do something like this:

`$ lua expander.lua your_file.lua > expanded.lua`
