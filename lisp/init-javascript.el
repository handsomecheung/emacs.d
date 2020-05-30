(require-package 'js3-mode)
(when (>= emacs-major-version 24)
  (require-package 'js2-mode))
(require-package 'rainbow-delimiters)
;; (require-package 'js-comint)
;; (require-package 'coffee-mode)


(defcustom preferred-javascript-mode
  (first (remove-if-not #'fboundp '(js2-mode js3-mode)))
  "Javascript mode to use for .js files."
  :type 'symbol
  :group 'programming
  :options '(js2-mode js3-mode js-mode))
(defvar preferred-javascript-indent-level 2)

;; Need to first remove from list if present, since elpa adds entries too, which
;; may be in an arbitrary order
(eval-when-compile (require 'cl))
(setq auto-mode-alist (cons `("\\.js\\(\\.erb\\)?\\'" . ,preferred-javascript-mode)
                            (loop for entry in auto-mode-alist
                                  unless (eq preferred-javascript-mode (cdr entry))
                                  collect entry)))


;; -----------------------------------
;; js2-mode
;; -----------------------------------
(add-hook 'js2-mode-hook '(lambda () (setq mode-name "JS2")))
(setq js2-use-font-lock-faces t
      js2-mode-must-byte-compile nil
      js2-basic-offset preferred-javascript-indent-level
      js2-indent-on-enter-key t
      js2-auto-indent-p t
      js2-bounce-indent-p nil)

;; Let flycheck handle parse errors
(setq js2-show-parse-errors nil)
(setq js2-strict-missing-semi-warning nil)
(setq js2-strict-trailing-comma-warning nil)

(eval-after-load 'js2-mode '(js2-imenu-extras-setup))
;; -----------------------------------

;; js3-mode
(add-hook 'js3-mode-hook '(lambda () (setq mode-name "JS3")))
(setq js3-auto-indent-p t
      js3-enter-indents-newline t
      js3-indent-on-enter-key t
      js3-indent-level preferred-javascript-indent-level)

;; js-mode
(setq js-indent-level preferred-javascript-indent-level)


;; standard javascript-mode
(setq javascript-indent-level preferred-javascript-indent-level)

(add-to-list 'interpreter-mode-alist (cons "node" preferred-javascript-mode))


(eval-after-load 'coffee-mode
  `(setq coffee-js-mode preferred-javascript-mode
         coffee-tab-width preferred-javascript-indent-level))

(add-to-list 'auto-mode-alist '("\\.coffee\\.erb\\'" . coffee-mode))

;; ---------------------------------------------------------------------------
;; Run and interact with an inferior JS via js-comint.el
;; ---------------------------------------------------------------------------

(setq inferior-js-program-command "js")

(defvar inferior-js-minor-mode-map (make-sparse-keymap))
(define-key inferior-js-minor-mode-map "\C-x\C-e" 'js-send-last-sexp)
(define-key inferior-js-minor-mode-map "\C-\M-x" 'js-send-last-sexp-and-go)
(define-key inferior-js-minor-mode-map "\C-cb" 'js-send-buffer)
(define-key inferior-js-minor-mode-map "\C-c\C-b" 'js-send-buffer-and-go)
(define-key inferior-js-minor-mode-map "\C-cl" 'js-load-file-and-go)

(define-minor-mode inferior-js-keys-mode
  "Bindings for communicating with an inferior js interpreter."
  nil " InfJS" inferior-js-minor-mode-map)

(dolist (hook '(js2-mode-hook js3-mode-hook js-mode-hook))
  (add-hook hook 'inferior-js-keys-mode))


;; -----------------------------------
;; web-mode
;; major mode for editing web templates. which can handle mixed js and html like jsx
;; -----------------------------------
(require-package 'web-mode)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(flycheck-add-mode 'javascript-eslint 'web-mode)

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
;; -----------------------------------


;; -----------------------------------
;; eslint
;; -----------------------------------
(let ((nvm-bin (concat (getenv "HOME") "/.nvm/versions/node/v10.16.0/bin")))
  (setenv "PATH" (concat nvm-bin ":" (getenv "PATH")))
  (setq exec-path (append exec-path (list nvm-bin))))

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
              (append flycheck-disabled-checkers
                      '(javascript-jshint)))
;; -----------------------------------



(provide 'init-javascript)
