; extends

(script_element
  ; Define the structure we expect: a start_tag containing the attribute
  (start_tag
    (attribute
      (attribute_name) @_attr_name ; Capture name
      (quoted_attribute_value) @_attr_value)) ; Capture value WITH quotes
  ; Also find the content node
  (raw_text) @injection.content
  ; Apply conditions based on captures made above
  (#eq? @_attr_name "type") ; Check captured name
  (#match? @_attr_value "'text/babel'|\"text/babel\"") ; Check captured value (must include quotes)
  ; Apply the injection
  (#set! injection.language "javascript"))
