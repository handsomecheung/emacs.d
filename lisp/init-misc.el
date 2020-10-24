;;----------------------------------------------------------------------------
;; Misc config - yet to be placed in separate files
;;--------------------------------------------------------------------------------
(require 'misc)
(global-set-key (kbd "C-M-y") 'copy-from-above-command)

;;--------------------------------------------------------------------------------

;; --------------------------------------------------------------------------------
;; Increment and Decrement Integer at Point
;; --------------------------------------------------------------------------------
(require 'thingatpt)

(defun thing-at-point-goto-end-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip over optional sign
    (when (looking-at "[+-]")
      (forward-char 1))
    ;; Skip over digits
    (skip-chars-forward "[[:digit:]]")
    ;; Check for at least one digit
    (unless (looking-back "[[:digit:]]")
      (error "No integer here"))))
(put 'integer 'beginning-op 'thing-at-point-goto-end-of-integer)

(defun thing-at-point-goto-beginning-of-integer ()
  "Go to end of integer at point."
  (let ((inhibit-changing-match-data t))
    ;; Skip backward over digits
    (skip-chars-backward "[[:digit:]]")
    ;; Check for digits and optional sign
    (unless (looking-at "[+-]?[[:digit:]]")
      (error "No integer here"))
    ;; Skip backward over optional sign
    (when (looking-back "[+-]")
        (backward-char 1))))
(put 'integer 'beginning-op 'thing-at-point-goto-beginning-of-integer)

(defun thing-at-point-bounds-of-integer-at-point ()
  "Get boundaries of integer at point."
  (save-excursion
    (let (beg end)
      (thing-at-point-goto-beginning-of-integer)
      (setq beg (point))
      (thing-at-point-goto-end-of-integer)
      (setq end (point))
      (cons beg end))))
(put 'integer 'bounds-of-thing-at-point 'thing-at-point-bounds-of-integer-at-point)

(defun thing-at-point-integer-at-point ()
  "Get integer at point."
  (let ((bounds (bounds-of-thing-at-point 'integer)))
    (string-to-number (buffer-substring (car bounds) (cdr bounds)))))
(put 'integer 'thing-at-point 'thing-at-point-integer-at-point)

(defun increment-integer-at-point (&optional inc)
  "Increment integer at point by one.

With numeric prefix arg INC, increment the integer by INC amount."
  (interactive "p")
  (let ((inc (or inc 1))
        (n (thing-at-point 'integer))
        (bounds (bounds-of-thing-at-point 'integer)))
    (delete-region (car bounds) (cdr bounds))
    (insert (int-to-string (+ n inc)))))

(defun decrement-integer-at-point (&optional dec)
  "Decrement integer at point by one.

With numeric prefix arg DEC, decrement the integer by DEC amount."
  (interactive "p")
  (increment-integer-at-point (- (or dec 1))))

(global-set-key (kbd "C-c +") 'increment-integer-at-point)
(global-set-key (kbd "C-c -") 'decrement-integer-at-point)

;; --------------------------------------------------------------------------------

(defun shell-command-to-string-no-newline(command)
  (substring (shell-command-to-string command) 0 -1))

;; --------------------------------------------------------------------------------
;;  default dir
;; --------------------------------------------------------------------------------
(let ((server-name (shell-command-to-string-no-newline "uname -n")))
  (cond ((and (equalp server-name "t4f-mbp-13552.local") *is-a-mac*) (setq default-directory "~/ke_code"))
        ((equalp server-name "t4f-mbp-13552") (setq default-directory "~/ke_code"))
        ((equalp server-name "hc-server") (setq default-directory "~/"))
        ((setq default-directory "~/"))))
;; --------------------------------------------------------------------------------

;;--------------------------------------------------------------------------------
(defun eval-and-replace ()
  "Replace the preceding sexp with its value."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (prin1 (eval (read (current-kill 0)))
             (current-buffer))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(global-set-key (kbd "C-c e") 'eval-and-replace)
;;--------------------------------------------------------------------------------

;--------------------------------------------------------------------------------
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char: ")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
             char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))

(define-key global-map (kbd "C-c f") 'wy-go-to-char)

;--------------------------------------------------------------------------------

;;----------------------------------------------------------------------------
(add-auto-mode 'tcl-mode "Portfile\\'")
(fset 'yes-or-no-p 'y-or-n-p)
(mouse-avoidance-mode 'animate)

(setq-default indent-tabs-mode nil)    ; use only spaces and no tabs
(setq default-tab-width 4)
;; (global-whitespace-mode 1)

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
(setq frame-title-format '("Emacs@" (:eval (frame-title-string))))
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

(defun smart-join-line (region? start end up-or-down)
  "Join the lines in region, if no region, join current line."
  (if region?
      (progn (goto-char start)
             (let ((lines (count-lines start end)))
               (while (> lines 0)
                 (delete-indentation 1)
                 (setq lines (- lines 1))))
             (deactivate-mark))
    (delete-indentation up-or-down)))

(defun smart-join-line-up (start end)
  "smart join lines up"
  (interactive "r")
  (smart-join-line (use-region-p) start end 1))

(defun smart-join-line-down (start end)
  "smart join lines up"
  (interactive "r")
  (smart-join-line (use-region-p) start end nil))

(global-set-key (kbd "C-^") 'smart-join-line-up)
(global-set-key (kbd "M-^") 'smart-join-line-down)


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
(global-set-key (kbd "M-o") 'smart-open-line-above)


;; highlight current line
;; (global-hl-line-mode 1)

;; (which-function-mode 1)
;; (setq-default header-line-format
;;               '((which-func-mode ("" which-func-format " "))))

(autoload 'which-function "which-func")
(autoload 'popup-tip "popup")
(defun popup-which-function ()
  (interactive)
  (popup-tip (which-function)))
(global-set-key (kbd "<f5>") 'popup-which-function)


(setq confirm-kill-emacs 'yes-or-no-p)

(defun ask-before-closing ()
  "Close only if y was pressed."
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to close this frame? "))
      (save-buffers-kill-terminal)
    (message "Canceled frame close")))

(when (daemonp)
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

;; --------------------------------------------------------------------------------
;; minimap
;; --------------------------------------------------------------------------------
;; (require-package 'sublimity)
;; (require 'sublimity-map)
;; (require 'sublimity-scroll)
;; (require 'sublimity-attractive)

;; (sublimity-mode 1)

;; (setq sublimity-scroll-weight 10
;;       sublimity-scroll-drift-length 5)
;; (setq sublimity-map-size 20)
;; (setq sublimity-map-fraction 0.3)
;; (setq sublimity-map-text-scale -7)

;; (add-hook 'sublimity-map-setup-hook
;;           (lambda ()
;;             (setq buffer-face-mode-face '(:family "Monospace"))
;;             (buffer-face-mode)))

;; (sublimity-map-set-delay 2)

;; (setq sublimity-attractive-centering-width 110)

;; (sublimity-attractive-hide-bars)
;; (sublimity-attractive-hide-vertical-border)
;; (sublimity-attractive-hide-fringes)
;; (sublimity-attractive-hide-modelines)

;; --------------------------------------------------------------------------------

;; --------------------------------------------------------------------------------
;; key guide
;; --------------------------------------------------------------------------------
;; (require-package 'guide-key)
;; (setq guide-key/guide-key-sequence '("C-x r" "C-x 4"))
;; (guide-key-mode 1)
;; --------------------------------------------------------------------------------

(require-package 'google-translate)
(require 'google-translate-default-ui)
(global-set-key (kbd "C-c t") 'google-translate-at-point)
(global-set-key (kbd "C-c T") 'google-translate-query-translate)

(setq enable-local-variables :safe)

(defun my-modify-syntax ()
  (progn (modify-syntax-entry ?- "w")
         (modify-syntax-entry ?_ "w")
         (modify-syntax-entry ?? "w")
         (modify-syntax-entry ?! "w")
         ))

(defun my-modify-syntax-lisp ()
  (progn (modify-syntax-entry ?- "w")
         (modify-syntax-entry ?_ "w")
         (modify-syntax-entry ?> "w")
         (modify-syntax-entry ?/ "w")
         (modify-syntax-entry ?& "w")
         (modify-syntax-entry ?? "w")
         (modify-syntax-entry ?! "w")
         (modify-syntax-entry ?* "w")
         ))

(progn
  (add-hook 'rust-mode-hook 'my-modify-syntax)
  (add-hook 'ruby-mode-hook 'my-modify-syntax)
  (add-hook 'python-mode-hook 'my-modify-syntax)
  (add-hook 'js2-mode-hook 'my-modify-syntax)
  (add-hook 'web-mode-hook 'my-modify-syntax)
  (add-hook 'sh-mode-hook 'my-modify-syntax)
  (add-hook 'scheme-mode-hook 'my-modify-syntax-lisp)
  (add-hook 'lisp-mode-hook 'my-modify-syntax-lisp)
  (add-hook 'emacs-lisp-mode-hook 'my-modify-syntax-lisp)
  (add-hook 'racket-mode-hook 'my-modify-syntax-lisp)
  )


(provide 'init-misc)
