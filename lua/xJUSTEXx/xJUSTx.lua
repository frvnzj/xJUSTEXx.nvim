local M = {}

local fidget = require('fidget')

function M.just(command)
  local handle = fidget.progress.handle.create({
    title = 'Just: ' .. command,
    message = 'Compiling ' .. vim.fn.expand('%') .. '...',
    lsp_client = { name = 'xJUSTEXx' },
    percentage = 0,
  })

  local cmd = 'just ' .. command

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        handle:report({
          message = 'Compiling ' .. vim.fn.expand('%') .. '...',
        })
      end
    end,
    on_stderr = function(_, data)
      if data then
        handle:report({
          message = 'Compiling ' .. vim.fn.expand('%') .. '...',
          percentage = 50,
        })
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        handle:finish()
      else
        handle:report({
          message = 'Failed',
        })
        handle:finish()
      end
      -- vim.notify("Just command '" .. command .. "' finished with code: " .. code)
    end,
  })
end

return M
