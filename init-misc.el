;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)
(mouse-avoidance-mode 'animate)

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)
;; (global-whitespace-mode 1)
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


;; display buffer name or absolute file path name in the frame title
(defun frame-title-string ()
  "Return the file name of current buffer, using ~ if under home directory"
  (let
      ((fname (or
           (buffer-file-name (current-buffer))
           (buffer-name)))
       (max-len 80))
    (when (string-match (getenv "HOME") fname)
      (setq fname (replace-match "~" t t fname)))
    (if (> (length fname) max-len)
    (setq fname
          (concat "..."
              (substring fname (- (length fname) max-len)))))
    fname))
(setq frame-title-format '("hc-Emacs@"(:eval (frame-title-string))))
;(setq frame-title-format "%b@emacs")

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

;;rebind M-v, avoid it's binded to ns-paste-secondary in GUI on Mac
(global-set-key (kbd "M-v") 'cua-scroll-down)

(defun top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))

(global-set-key (kbd "C-^") 'top-join-line)

(add-hook 'before-save-hook 'whitespace-cleanup)

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))

;; (global-set-key [(shift return)] 'smart-open-line)

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at it's beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))

;; (global-set-key [(control shift return)] 'smart-open-line-above)

(global-set-key (kbd "C-o") 'smart-open-line)
(global-set-key (kbd "m-o") 'smart-open-line-above)

(provide 'init-misc)
