return {
  "nvim-neotest/neotest",
  dependencies = {
    "haydenmeade/neotest-jest",
  },
  lazy = true,
  opts = function()
    return {
      adapters = {
        require "neotest-jest" {
          jestCommand = "npm test --",
          jestConfigFile = "jest.config.ts",
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        },
      },
    }
  end,
}
