local directory = nil

function file_read(filename)
    local file, err = io.open(directory..filename, "r")
    local data = {}
    if not (file == nil) then
        for line in file:lines() do
            table.insert (data, line)
        end
        file:close()
    else
        print("Error: could not open file \"".. directory..filename .. "\".")
    end 
    return data
end

function expand(lines)
    local data = {}
    for i=1, #lines do
        local j, k = string.find(lines[i], "dofile")
        if not (j == nil) then
            local b1_j, b1_k = string.find(lines[i], "\"", k)
            local new_file = string.sub(lines[i], b1_k+1, string.find(lines[i], "\"", b1_k+1)-1)
            table.insert(data, "--------------------- " .. new_file .. " ---------------------")
            new_file = expand(file_read(new_file))
            for s,l in pairs(new_file) do
                table.insert(data, l)
            end
        else
            table.insert(data, lines[i])
        end
    end
    return data
end

directory = arg[2]
if directory == nil then
    directory = ""
end
if (arg[1] == nil) or (string.len(arg[1]) == 0) then
    print("Usage: \n\tlua expander.lua file.lua directory/ (optional)")
else
    local expanded = expand({"dofile(\""..arg[1].."\")"})
    for s,l in pairs(expanded) do   
        print(l)
    end
end