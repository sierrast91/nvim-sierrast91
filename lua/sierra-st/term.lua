local api = vim.api
local g = vim.g
local M = {}
local set_buf = api.nvim_set_current_buf
local cur_win = api.nvim_get_current_win

g.sy_teset_buf = {}

local pos_data = {
  sp = { resize = 'height', area = 'lines' },
  ['bo sp'] = { resize = 'height', area = 'lines' },
}

local term_config = {
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, ['bo sp'] = 0.3 },
}
-- used for initially resizing terms
vim.g.sy_term_h = false

-------------------------- util funcs -----------------------------
local function save_term_info(index, val)
  local terms_list = g.sy_terms
  terms_list[tostring(index)] = val
  g.sy_terms = terms_list
end

local function format_cmd(cmd)
  return type(cmd) == 'string' and cmd or cmd()
end

M.display = function(term)
  vim.cmd(term.pos)

  local win = cur_win()
  term.win = win

  vim.bo[term.buf].buflisted = false
  vim.cmd 'startinsert'
  -- resize non floating wins initially + or only when they're toggleable
  if
    (term.pos == 'sp' and not vim.g.sy_term_v)
    or (term.pos == 'vsp' and not vim.g.sy_term_h)
    or (term.pos ~= 'float')
  then
    local pos_type = pos_data[term.pos]
    local size = term.size and term.size or term_config.sizes[term.pos]
    local new_size = vim.o[pos_type.area] * size
    api['nvim_win_set_' .. pos_type.resize](0, math.floor(new_size))
  end

  set_buf(win, term.buf)

  local winopts = vim.tbl_deep_extend('force', term_config.winopts, term.winopts or {})

  for k, v in pairs(winopts) do
    vim.wo[win][k] = v
  end
end

local function create_term(opts)
  local buf_exists = opts.buf
  opts.buf = opts.buf or vim.api.nvim_create_buf(false, true)

  -- handle cmd opt
  local shell = vim.o.shell
  local cmd = shell

  if opts.cmd and opts.buf then
    cmd = { shell, '-c', format_cmd(opts.cmd) .. '; ' .. shell }
  end

  M.display(opts)

  save_term_info(opts.buf, opts)

  if not buf_exists then
    vim.fn.termopen(cmd)
  end

  vim.g.sy_term_h = opts.pos == 'sp'
end

--------------------------- user api -------------------------------
M.new = function(opts)
  create_term(opts)
end

M.toggle = function(opts)
  local x = g.sy_terms[opts.id]
  opts.buf = x and x.buf or nil

  if (x == nil or not api.nvim_buf_is_valid(x.buf)) or vim.fn.bufwinid(x.buf) == -1 then
    create(opts)
  else
    api.nvim_win_close(x.win, true)
  end
end

-- spawns term with *cmd & runs the *cmd if the keybind is run again
M.runner = function(opts)
  local x = term_by_id(opts.id)
  local clear_cmd = opts.clear_cmd or 'clear; '
  opts.buf = x and x.buf or nil

  -- if buf doesnt exist
  if x == nil then
    create(opts)
  else
    -- window isnt visible
    if vim.fn.bufwinid(x.buf) == -1 then
      M.display(opts)
    end

    local cmd = format_cmd(opts.cmd)

    if x.buf == api.nvim_get_current_buf() then
      set_buf(g.buf_history[#g.buf_history - 1])
      cmd = format_cmd(opts.cmd)
      set_buf(x.buf)
    end

    local job_id = vim.b[x.buf].terminal_job_id
    vim.api.nvim_chan_send(job_id, clear_cmd .. cmd .. ' \n')
  end
end

--------------------------- autocmds -------------------------------
api.nvim_create_autocmd('TermClose', {
  callback = function(args)
    save_term_info(args.buf, nil)
  end,
})

return M
