local space= " "

local languages=
{
   ["c"] = "//", -- C dilinde yorum satırı karakteri
   ["java"] = "//", -- Java dilinde yorum satırı karakteri
   ["py"] = "#", -- Python dilinde yorum satırı karakteri
   ["lua"] = "--", -- Lua dilinde yorum satırı karakteri
   ["cpp"] = "//", -- C++ dilinde yorum satırı karakteri
   ["vim"] = "\"", -- VimScript dilinde yorum satırı karakteri
}

local function get_current_file_extension()
  -- En son seçilen pencerenin ID'sini al
  local current_win = vim.api.nvim_get_current_win()
  -- Bu pencerenin tam dosya adını al
  local current_file = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(current_win))
  -- Dosya adındaki uzantıyı ayıkla ve geri döndür
  local extension = string.match(current_file, "%.([^.]+)$")
  return languages[extension]
end

local function comment_lines()

 local comment_prefix = get_current_file_extension() .. space
   -- Seçili satırları al
   local selected_lines = vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false)
   -- Yorum işareti ekleyerek seçili satırları güncelle
   for i, line in ipairs(selected_lines) do
     selected_lines[i] = comment_prefix .. line
   end
   -- Güncellenmiş satırları geri yaz
   vim.api.nvim_buf_set_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false, selected_lines)
end
function toggle_comment_current_line()
  local comment_char = get_current_file_extension() .. space
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
  if line then 
    local is_commented = string.sub(line, 1, #comment_char) == comment_char
    if is_commented then
      -- Satır zaten yorum satırıysa, yorum işaretini kaldırın
      vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {string.sub(line, #comment_char + 1)})
    else
      -- Satır yorum satırı değilse, yorum işareti ekleyin
      vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, false, {comment_char .. line})
    end
  end
end
local function toggle_comment()

  if vim.fn.visualmode() == 'v' then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]
    local comment_char = get_current_file_extension() .. space
    for i = start_line, end_line do
      local line = vim.api.nvim_buf_get_lines(0, i - 1, i, false)[1]
      if not line then error("Satır Seçilmedi") end
      local is_commented = string.sub(line, 1, #comment_char) == comment_char
      if is_commented then
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, {string.sub(line, #comment_char + 1)})
      else
        vim.api.nvim_buf_set_lines(0, i - 1, i, false, {comment_char .. line})
      end
    end
  elseif vim.fn.mode() == 'n' then
   toggle_comment_current_line()
  end
end


return 
{
  space = space,
  languages = languages,
  get_current_file_extension = get_current_file_extension,
  comment_line = toggle_comment_current_line,
  comment_block= toggle_comment
}
