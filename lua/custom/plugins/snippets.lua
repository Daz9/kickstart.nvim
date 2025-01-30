local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Function to extract a value using Tree-sitter
local function extract_branch_from_treesitter(args, parent)
  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, 'gitcommit')
  local tree = parser:parse()[1]
  local root = tree:root()

  -- Define the query to find the desired node
  local query = vim.treesitter.query.parse(
    'gitcommit',
    [[
    (branch) @branch_name
    ]]
  )

  -- Iterate over all matches of the query
  for id, node in query:iter_captures(root, bufnr, 0, -1) do
    local name = query.captures[id]
    if name == 'branch_name' then
      local func_name = vim.treesitter.get_node_text(node, bufnr)
      return func_name
    end
  end
  --
  return 'branchNameNotFound'
end

function extractTicket(branch_name)
  -- Look for the pattern "Ticket-", followed by one or more digits
  local ticket_identifier = branch_name:match '(%w+%-%d+)'
  if not ticket_identifier or ticket_identifier == '' then
    ticket_identifier = branch_name
  end
  return ticket_identifier
end

function getBranch()
  local fullBranch = extract_branch_from_treesitter(args, parent)
  local branchId = extractTicket(fullBranch)
  return branchId
end

ls.add_snippets('gitcommit', {
  s('D_feat', {
    t 'feat(',
    f(getBranch, {}),
    t '): ',
    i(1, 'title'),
  }),
})
--
return {}
