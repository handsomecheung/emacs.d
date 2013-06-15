;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)
(mouse-avoidance-mode 'animate)

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)
(whitespace-mode 1)
;-------------------------------------
; Emacs on Mac OS alt key problem

;; (setq mac-option-key-is-meta t)
;; (setq mac-command-key-is-meta t)
;; (setq mac-command-metamodifier)
;; (setq mac-option-modifier nil)
;;; I prefer cmd key for meta
(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier nil
      mac-option-modifier 'meta)
(global-set-key (kbd "<kp-delete>") 'delete-char)

;-------------------------------------

(dolist (hook (if (fboundp 'prog-mode)
                  '(prog-mode-hook ruby-mode-hook)
                '(find-file-hooks)))
  (add-hook hook 'goto-address-prog-mode))
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)
(setq goto-address-mail-face 'link)

(setq-default regex-tool-backend 'perl)

(add-hook 'find-file-hooks (lambda () (linum-mode 1)))

(setq frame-title-format "%b@emacs")


(setq user-full-name "Handsome Cheung")
(setq user-mail-address "handsomecheung@gmail.com")


;;;###autoload
(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.
Move point to beginning-of-line ,if point was already at that position,
  move point to first non-whitespace character. "
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-line)
    (and (= oldpos (point))
         (back-to-indentation) )))

;;;###autoload
(defun smart-end-of-line()
  "Move point to first non-whitespace character or end-of-line.
Move point to end-of-line ,if point was already at that position,
  move point to first non-whitespace character."
  (interactive)
  (let ((oldpos (point)))
    (beginning-of-line)
    (when (re-search-forward "[ \t]*$" (point-at-eol) t)
      (goto-char (match-beginning 0)))
    (when (= oldpos (point))
      (end-of-line))))


(global-set-key (kbd "C-a") 'smart-beginning-of-line)
(global-set-key (kbd "C-e") 'smart-end-of-line)

;(display-time-mode 1) ; 显示时间
;(setq display-time-24hr-format t) ; 24小时格式
;(setq display-time-day-and-date t) ; 显示日期
;(setq column-number-mode t) ; 显示列号


(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(defun strip-convert-lines-into-one-big-string (beg end)
"strip and convert selected lines into one big string which is copied into kill ring.
When transient-mark-mode is enabled, if no region is active then only the
current line is acted upon.

If the region begins or ends in the middle of a line, that entire line is
copied, even if the region is narrowed to the middle of a line.

Current position is preserved."
  (interactive "r")
  (let (str (orig-pos (point-marker)))
  (save-restriction
    (widen)
    (when (and transient-mark-mode (not (use-region-p)))
      (setq beg (line-beginning-position)
            end (line-beginning-position 2)))

    (goto-char beg)
    (setq beg (line-beginning-position))
    (goto-char end)
    (unless (= (point) (line-beginning-position))
      (setq end (line-beginning-position 2)))

    (goto-char beg)
    (setq str (replace-regexp-in-string "[ \t]*\n" "" (replace-regexp-in-string "^[ \t]+" "" (buffer-substring-no-properties beg end))))
    ;; (message "str=%s" str)
    (kill-new str)
    (goto-char orig-pos)))
  )

;(global-set-key (kbd "C-c C-y") 'strip-convert-lines-into-one-big-string)


(provide 'init-misc)
