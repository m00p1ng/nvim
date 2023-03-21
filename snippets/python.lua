local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local lct_template = [[
from typing import List
import unittest

__unittest = True  # pyright: ignore


class Test(unittest.TestCase):
    def helper(self, {params}, want):
        solution = Solution()
        got = solution.{function_name}
        self.assertEqual(got, want)

    def test_A1(self):
        self.helper(
            {user_params},
            want={want},
        )

    def test_B1(self):
        self.helper(
            {user_params},
            want={want},
        )


if __name__ == '__main__':
    unittest.main()
]]

local lct_snip = s(
  "lct",
  fmt(lct_template, {
    params = i(1, "params"),
    function_name = i(2, "function_name()"),
    user_params = i(3, 'params="test"'),
    want = i(4, '"want"'),
  })
)

local snippets = {
  lct_snip,
}

return snippets
