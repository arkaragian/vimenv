(generic_environment 
  begin: (begin
    name: (curly_group_text
      text: (text
        word: (word) @env-title)))
  ;; Select environment whose name is not document
  (#not-eq? @env-title "document")
  ) @latex.environment.outer

(generic_environment) @holaouter
