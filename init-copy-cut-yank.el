;;----------browse-kill-ring------------------------------
(require-package 'browse-kill-ring)
;; (global-set-key (kbd "C-c k") 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
;;--------------------------------------------------------------------------------

;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;(global-set-key (kbd "M-k") 'qiang-copy-line)

(defun copy-line (&optional arg)
  "Save current line into Kill-Ring without mark the line"
  (interactive "P")
  (let ((beg (line-beginning-position))
        (end (line-end-position arg)))
    (copy-region-as-kill beg end)))

(defun copy-word (&optional arg)
  "Copy words at point"
  (interactive "P")
  (let ((beg (progn (if (looking-back "[a-zA-Z0-9]" 1) (backward-word 1)) (point)))
        (end (progn (forward-word arg) (point))))
    (copy-region-as-kill beg end)))

(global-set-key (kbd "C-c w") 'copy-word)

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (let ((beg (progn (backward-paragraph 1) (point)))
        (end (progn (forward-paragraph arg) (point))))
    (copy-region-as-kill beg end)))

(defun zap-to-char-save (arg char)
  "Zap to a character, but save instead of kill."
  (interactive "p\ncZap to char: ")
  (save-excursion
    (zap-to-char arg char)
    (yank)))

(defun zap-up-to-char-save (arg char)
  "Zap up to a character, but save instead of kill."
  (interactive "p\ncZap up to char: ")
  (save-excursion
    (zap-up-to-char arg char)
    (yank)))


(global-set-key (kbd "C-M-z") 'zap-to-char-save)
(global-set-key (kbd "C-M-Z") 'zap-up-to-char-save)



(provide 'init-copy-cut-yank)
