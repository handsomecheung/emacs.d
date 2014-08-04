(require-package 'ruby-mode)
(require-package 'ruby-hash-syntax)
(require-package 'flymake-ruby)
(require-package 'rinari)
(require-package 'ruby-compilation)
(require-package 'inf-ruby)
;; (require-package 'robe)
(require-package 'yari)
(require-package 'yaml-mode)
(require-package 'flymake-yaml)
(require-package 'haml-mode)
(require-package 'ruby-electric)
;; (require-package 'mmm-mode)

(require-package 'ruby-tools)
(add-hook 'ruby-mode-hook 'ruby-tools-mode)

(require-package 'rvm)
(rvm-use-default)


(require-package 'textmate)
;; (textmate-mode)


;;------------------------------------------------------------
;; ruby-block-mode
;;------------------------------------------------------------
(require-package 'ruby-block)
(require 'ruby-block)
(add-hook 'ruby-mode-hook 'ruby-block-mode)
(setq ruby-block-highlight-toggle t)

;; (ruby-block-mode t)
;; ;; do overlay
;; (setq ruby-block-highlight-toggle 'overlay)
;; ;; display to minibuffer
;; (setq ruby-block-highlight-toggle 'minibuffer)
;; ;; display to minibuffer and do overlay
;;------------------------------------------------------------

;;------------------------------------------------------------
;; company-inf-ruby
;;------------------------------------------------------------
;; (require-package 'company-inf-ruby)
;; (add-hook 'inf-ruby-mode-hook (lambda () (require 'company-inf-ruby)))
;; (setq company-idle-delay 0.1)
;; (setq company-minimum-prefix-length 2)
;;------------------------------------------------------------



(eval-after-load 'rinari
  '(diminish 'rinari-minor-mode "Rin"))

(add-auto-mode 'ruby-mode
               "Rakefile\\'" "\\.rake\\'" "\.rxml\\'"
               "\\.rjs\\'" ".irbrc\\'" "\.builder\\'" "\\.ru\\'"
               "\\.gemspec\\'" "Gemfile\\'" "Kirkfile\\'")


(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")

(setq ruby-use-encoding-map nil)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "TAB") 'indent-for-tab-command)))


;;----------------------------------------------------------------------------
;; Ruby - flymake
;;----------------------------------------------------------------------------
(add-hook 'ruby-mode-hook 'flymake-ruby-load)


;;----------------------------------------------------------------------------
;; Ruby - robe
;;----------------------------------------------------------------------------
;; (add-hook 'ruby-mode-hook 'robe-mode)
;; (add-hook 'robe-mode-hook
;;           (lambda ()
;;             (add-to-list 'ac-sources 'ac-source-robe)
;;             (set-auto-complete-as-completion-at-point-function)))

;;--------------------------------------------------------------------------------
;; ruby-electric
;;--------------------------------------------------------------------------------
;; (add-hook 'ruby-mode-hook 'ruby-electric-mode)
;; (add-hook 'ruby-mode-hook '(lambda ()
;;                                ;; make ruby-electric play nice with autopair
;;                                (substitute-key-definition 'ruby-electric-curlies nil ruby-mode-map)
;;                                (substitute-key-definition 'ruby-electric-matching-char nil ruby-mode-map)
;;                                (substitute-key-definition 'ruby-electric-close-matching-char nil ruby-mode-map)))

;; # avoid ruby-electric conflicting with autopair

(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "{" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "(" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "[" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "}" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map ")" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "]" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "\"" nil)))
(add-hook 'ruby-electric-mode-hook
          '(lambda ()
             (define-key ruby-mode-map "\'" nil)))

;;--------------------------------------------------------------------------------


;;----------------------------------------------------------------------------
;; Ruby - misc
;;----------------------------------------------------------------------------
(defalias 'ri 'yari)

(add-hook 'yaml-mode-hook 'flymake-yaml-load)


;;----------------------------------------------------------------------------
;; Ruby - erb
;;----------------------------------------------------------------------------
(defun sanityinc/ensure-mmm-erb-loaded ()
  (require 'mmm-erb))

(require 'derived)

(defun sanityinc/set-up-mode-for-erb (mode)
  (add-hook (derived-mode-hook-name mode) 'sanityinc/ensure-mmm-erb-loaded)
  (mmm-add-mode-ext-class mode "\\.erb\\'" 'erb))

(let ((html-erb-modes '(html-mode html-erb-mode nxml-mode)))
  (dolist (mode html-erb-modes)
    (sanityinc/set-up-mode-for-erb mode)
    (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-js)
    (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-css)))

(mapc 'sanityinc/set-up-mode-for-erb
      '(coffee-mode js-mode js2-mode js3-mode markdown-mode textile-mode))

(require-package 'tagedit)
(eval-after-load "sgml-mode"
  '(progn
     (tagedit-add-paredit-like-keybindings)))

(mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)

(add-auto-mode 'html-erb-mode "\\.rhtml\\'" "\\.html\\.erb\\'")
(add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))
(mmm-add-mode-ext-class 'yaml-mode "\\.yaml\\'" 'erb)

(dolist (mode (list 'js-mode 'js2-mode 'js3-mode))
  (mmm-add-mode-ext-class mode "\\.js\\.erb\\'" 'erb))


;;----------------------------------------------------------------------------
;; Ruby - my convention for heredocs containing SQL
;;----------------------------------------------------------------------------
;; (eval-after-load 'mmm-mode
;;   '(progn
;;      (mmm-add-classes
;;       '((ruby-heredoc-sql
;;          :submode sql-mode
;;          :front "<<-?[\'\"]?\\(end_sql\\)[\'\"]?"
;;          :save-matches 1
;;          :front-offset (end-of-line 1)
;;          :back "^[ \t]*~1$"
;;          :delimiter-mode nil)))
;;      (mmm-add-mode-ext-class 'ruby-mode "\\.rb\\'" 'ruby-heredoc-sql)))


;;----------------------------------------------------------------------------
;; Ruby - compilation
;;----------------------------------------------------------------------------

; run the current buffer using Shift-F7
(add-hook 'ruby-mode-hook (lambda () (local-set-key [S-f7] 'ruby-compilation-this-buffer)))
; run the current test function using F8 key
(add-hook 'ruby-mode-hook (lambda () (local-set-key [f7] 'ruby-compilation-this-test)))

(add-hook 'ruby-mode-hook (lambda () (local-set-key [f6] 'recompile)))




;; Stupidly the standard Emacs ruby-mode isn't a derived mode of prog-mode:
;; we run the latter's hooks anyway
(add-hook 'ruby-mode-hook
          (lambda ()
            (unless (derived-mode-p 'prog-mode)
              (run-hooks 'prog-mode-hook))))

(defun ruby-insert-end ()
  "Insert \"end\" at point and reindent current line."
  (interactive)
  (insert "end")
  (ruby-indent-line t)
  (end-of-line))

(provide 'init-ruby-mode)
