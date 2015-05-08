(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))

(defun insert-list-newline (lst)
  "insert list, each of a newline"
  (if (not (equal lst nil))
      (let* ((first-item (car lst))
             (string (if (equal first-item nil) "" first-item)))
        (progn (insert (trim-string string))
               (newline)
               (insert-list-newline (cdr lst))))))

(defun get-line-string (line-number)
  "get specific line string"
  (save-excursion (progn (goto-line line-number)
          (trim-string (buffer-substring-no-properties (line-beginning-position) (line-end-position))))))

(defun nth (n list)
  "Returns the Nth element of LIST.
     N counts from zero.  If LIST is not that long, nil is returned."
  (car (nthcdr n list)))


(provide 'init-common-function)
