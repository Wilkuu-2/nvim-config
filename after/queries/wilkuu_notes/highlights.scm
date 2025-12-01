(string_lit) @string
(number_lit) @number
(const_words) @constant
(simple_line_stmt) @string

(type_param (identifier)) @type


(type_param_list
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

(section (":")) @punctuation.delimiter
(stmt (":")) @punctuation.delimiter
(data_stmt (":")) @punctuation.delimiter 
;(simple_line_stmt ("!")) @punctuation.delimiter 
(expr (",") @punctuation.delimiter)

(section 
  name: (identifier)) @type
(stmt 
  name: (identifier)) @property

(type_keyword) @type
(stmt_keyword) @keyword
(section_keyword) @keyword
; (comment) @ comment 

(hash 
  name: (identifier) @constant)
(injection (identifier) @constant)
