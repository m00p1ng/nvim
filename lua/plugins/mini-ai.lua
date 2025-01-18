return {
  "echasnovski/mini.ai",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    -- How to search for object (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'previous', 'nearest'.
    -- search_method = "cover",
    -- n_lines = 1000,
  },
}
