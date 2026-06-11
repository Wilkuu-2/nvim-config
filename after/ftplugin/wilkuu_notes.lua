local ts = vim.treesitter

local function get_indent_char(depth) 
  if depth == 0 then 
    return ""
  end 
  if depth %2 == 0 then 
    return ".>"
  else
    return ">"
  end 
end

local function indent_width()
  local sw = vim.bo.shiftwidth

  if sw == 0 then
    return vim.bo.tabstop
  end

  return sw
end

local indent_query = ts.query.get("wilkuu_notes", "indents")

local function get_indent_depth(bufnr, lnum)
  if not indent_query then
    print("wilkuu_notes_ft: Query missing!!")
    return 0
  end

  local parser = ts.get_parser(bufnr, "wilkuu_notes")
  local tree = parser:parse()[1]

  if not tree then
    print("wilkuu_notes_ft: Tree missing!!")
    return 0
  end

  local root = tree:root()
  local depth = 0

  for id, node in indent_query:iter_captures(root, bufnr) do
    local capture = indent_query.captures[id]
    print(capture)
    if capture == "indent_ignore" then 
      local start_row, _, end_row, _ = node:range() 
      print("sr,er")
      print(start_row)
      print(end_row)
      print(lnum)
      -- End the search when in injection, since we do not want to mess around with injections
      if lnum > start_row and lnum <= end_row then 
        print("returning nil")
        return nil 
      end
    elseif capture == "indent" then
      local start_row, _, end_row, _ = node:range()
      print("sr,er")
      print(start_row)
      print(end_row)
      print(lnum)
      -- If current line is inside this node,
      -- it contributes indentation depth
      if lnum > start_row and lnum <= end_row then
        depth = depth + 1
      end
    end
  end

  return depth
end


function _G.WNIndent()
  local lnum = vim.fn.line(".") 
  print("lnum")
  print(lnum)
  if lnum == 1 then return 0 end 
  local prevline = vim.fn.getline(lnum - 1)
  local width = indent_width()

  local depth = get_indent_depth(bufnr, lnum)
  if not depth then return nil end 
  print("depth,width")
  print(depth)
  print(width)

  return depth * width
end

vim.bo.autoindent = true
vim.bo.smartindent = false
vim.bo.cindent = false
vim.bo.indentexpr = "v:lua.WNIndent()"

vim.keymap.set("i", "<CR>", function()
   local nextline = vim.fn.line(".") + 1
   vim.v.lnum = nextline 

  local indent = _G.WNIndent()
  if not indent then 
    return "<CR>" 
  end 
  width = indent_width()
  local depth = math.floor(indent / width)
  print(depth)
  print(width)

  local prefix = get_indent_char(depth)

  return string.format("<CR>%s%s ", string.rep(" ", indent), prefix)
end, {
  expr = true,
  buffer = true,
})

local function rewrite_indent(delta)
  local line = vim.api.nvim_get_current_line()
  local recommended_indent = WNIndent() 
  if not recommended_indent then return true end 

  -- Match:
  -- leading spaces
  -- optional prefix (> or .>)
  -- rest of line
  local spaces, prefix, rest =
    line:match("^(%s*)(%.?>)(.*)$")

  local width = indent_width()
  if not spaces or not prefix then
    -- No prefix yet
    if not rest then rest = "" end 
    new_prefix = get_indent_char(recommended_indent / width)
    spaces = string.rep(" ", recommended_indent)
    vim.api.nvim_set_current_line(
      spaces .. new_prefix .. rest
    )
  end


  local current_depth = math.floor(#spaces / width)

  if prefix then
    current_depth = current_depth + 1
  end

  local new_depth = math.max(0, current_depth + delta)

  if new_depth == 0 then
    vim.api.nvim_set_current_line(rest:gsub("^%s*", ""))
    return
  end

  local indent = string.rep(" ", (new_depth - 1) * width)

  local new_prefix = get_indent_char(new_depth - 1)

  vim.api.nvim_set_current_line(
    indent .. new_prefix .. rest
  )


  vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], ((new_depth-1)*width)+#new_prefix})
  return false
end

-- Tab = indent
vim.keymap.set("n", "<Tab>", function()
  if rewrite_indent(1) then return "<Tab>" end
end, { buffer = true })

-- Shift-Tab = dedent
vim.keymap.set("n", "<S-Tab>", function()
  if rewrite_indent(-1) then 
    return "<S-Tab>" 
  end
end, { buffer = true })

-- Optional: insert mode support
vim.keymap.set("i", "<Tab>", function()
  if rewrite_indent(1) then return "<Tab>" end
end, { buffer = true  })

vim.keymap.set("i", "<S-Tab>", function()
  if rewrite_indent(-1) then return "<S-Tab>" end
end, { buffer = true })
