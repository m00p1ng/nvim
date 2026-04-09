-- Shared local LLM config used by chat and completion providers
local local_llm = {
  name = "qwen3-coder",
  model = "qwen3-coder-30b-a3b-instruct-mlx",
  host = "http://localhost:11434",
  api_key = "TERM",
}

return local_llm
