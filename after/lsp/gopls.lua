-- workaround for gopls not supporting semanticTokensProvider
-- https://github.com/golang/go/issues/54531#issuecomment-1464982242

return {
  settings = {
    gopls = {
      hints = {
        -- assignVariableTypes = true,
        -- compositeLiteralFields = true,
        -- compositeLiteralTypes = true,
        -- constantValues = true,
        -- functionTypeParameters = true,
        parameterNames = true,
        -- rangeVariableTypes = true,
      },
    },
  },
}
