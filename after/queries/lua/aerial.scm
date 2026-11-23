; extends

(assignment_statement
  (variable_list
    name: (identifier) @name)
  (expression_list
    value: (string) @symbol)
  (#set! "kind" "String")) @start

(assignment_statement
  (variable_list
    name: (identifier) @name)
  (expression_list
    value: (table_constructor) @symbol)
  (#set! "kind" "Struct")) @start
