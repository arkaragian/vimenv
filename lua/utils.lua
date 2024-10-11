function print_header(title)
    local header_width = 78
    local comment_line = string.rep("-", header_width)
    
    -- Insert spaces between letters and double the spaces between words
    local spaced_title = title:sub(1,1)
    for i = 2, #title do
        local char = title:sub(i,i)
        if char == " " then
            spaced_title = spaced_title .. "  "  -- Double the space
        else
            spaced_title = spaced_title .. " " .. char
        end
    end
    
    -- Center the title within the header
    local padding = (header_width - #spaced_title - 8) // 2
    local centered_title = string.rep(" ", padding) .. spaced_title .. string.rep(" ", padding)
    
    -- Ensure the title fits exactly, adjusting padding if needed
    if #centered_title + 8 < header_width then
        centered_title = centered_title .. " "
    end
    
    -- Print the header
    print(comment_line)
    print("--" .. centered_title .. "--")
    print(comment_line)
end
