; extends

(
  (comment) @injection.language
  .
  (template_string) @injection.content
  (#match? @injection.language "\\*\\s*(html|css|sql|graphql|gql)\\s*\\*")
  (#gsub! @injection.language "/%*%s*(%w+)%s*%*/" "%1")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
)
