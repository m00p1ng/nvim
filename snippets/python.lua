local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local lct_template = [[
# {template}
from typing import List
import unittest

__unittest = True  # pyright: ignore


class Test(unittest.TestCase):
    def helper(self, {params}, want):
        solution = Solution()
        got = solution.function()
        self.assertEqual(got, want)

    def test_A1(self):
        self.helper(

            want=,
        )

    def test_B1(self):
        self.helper(

            want=,
        )


if __name__ == '__main__':
    unittest.main()
]]

local lct_snip = s(
  "lct",
  fmt(lct_template, {
    template = i(1, "template"),
    params = i(2, "params"),
  })
)

local lch_template = [[
def test_C1(self):
    self.helper(
        {user_params},
    )
]]

local lch_snip = s(
  "lch",
  fmt(lch_template, {
    user_params = i(1, ""),
  })
)

local snippets = {
  lct_snip,
  lch_snip,
}

return snippets
