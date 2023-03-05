local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local snippets = {
  s(
    "lctest",
    fmt(
      [[
      import unittest

      class Test(unittest.TestCase):
          def helper(self, {params}):
              result = self.{function_name}
              self.assertEqual(result, expected)

          def test_1(self):
              self.helper(
                {user_params},
                expected = {expected}
              )


      if __name__ == '__main__':
          unittest.main()
      ]],
      {
        params = i(1, "params"),
        function_name = i(2, "function_name()"),
        user_params = i(3, "name = \"test\""),
        expected = i(4, "\"expected\""),
      }
    )
  ),
}

return snippets
