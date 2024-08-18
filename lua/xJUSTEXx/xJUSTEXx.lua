local M = {}

local config = require('xJUSTEXx.config')

local function create_floating_window()
  local width = vim.api.nvim_get_option_value('columns', {})
  local height = vim.api.nvim_get_option_value('lines', {})

  local win_width = math.ceil(width * 0.5)
  local win_height = 1
  local row = math.ceil((height - win_height) / 2)
  local col = math.ceil((width - win_width) / 2)

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  vim.api.nvim_set_option_value('buftype', 'prompt', { buf = buf })

  vim.fn.prompt_setprompt(buf, 'Name of the article: ')

  return buf, win
end

local function setup_project(project_name)
  project_name = project_name:gsub('%s+', '_')

  if project_name and project_name ~= '' then
    local project_dir = config.options.project_dir .. '/' .. project_name

    vim.fn.mkdir(project_dir, 'p')

    vim.cmd('cd ' .. project_dir)

    vim.fn.system('git init')

    local main_tex_path = project_dir .. '/' .. project_name .. '.tex'
    vim.fn.writefile(vim.split(config.options.tex_content, '\n'), main_tex_path)

    vim.cmd('edit ' .. main_tex_path)

    local justfile_path = project_dir .. '/.justfile'
    local justfile_content = config.set_file_justfile(project_name)
    vim.fn.writefile(vim.split(justfile_content, '\n'), justfile_path)

    vim.notify('Project  setup complete!', vim.log.levels.INFO)
  else
    vim.notify('Project  creation cancelled', vim.log.levels.INFO)
  end
end

function M.create_tex_project_article()
  local buf, win = create_floating_window()

  vim.fn.prompt_setcallback(buf, function(input)
    vim.api.nvim_win_close(win, true)
    vim.api.nvim_buf_delete(buf, { force = true })

    if vim.fn.trim(input) ~= '' then
      setup_project(input)
    else
      vim.notify('Project  creation cancelled', vim.log.levels.INFO)
    end
  end)

  vim.cmd('startinsert')
end

return M
