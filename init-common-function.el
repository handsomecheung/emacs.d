(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun insert-list-newline (lst)
  "insert list, each of a newline"
  (if (not (equal lst nil)) (progn (insert (trim-string (car lst)))
                                   (newline)
                                   (insert-list-newline (cdr lst)))))

(provide 'init-common-function)
