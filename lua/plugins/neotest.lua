return {
  "nvim-neotest/neotest",
  dependencies = {
    "haydenmeade/neotest-jest",
    "nvim-neotest/neotest-python",
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
        require "neotest-python" {
          runner = "unittest",
        },
      },
    }
  end,
}
