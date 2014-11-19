(require-package 'sml-mode)

;; *** set this path to the directory containing "sml-mode-color.el"
;; (setq sml-mode-dir "/path/to/sml-mode-directory")

;; *** set this path to the sml executable (sml.bat on Windows)
(setq sml-prog-name "/usr/lib/smlnj/bin/sml")

;; (add-to-list 'load-path sml-mode-dir)
;; (autoload 'sml-mode "sml-mode-color" () t)

(add-to-list 'auto-mode-alist '("\\.sml$" . sml-mode))
(add-to-list 'auto-mode-alist '("\\.sig$" . sml-mode))

(add-hook 'sml-mode-hook
   (lambda ()
     (setq indent-tabs-mode nil)
     (setq sml-indent-args 2)
     (local-set-key (kbd "M-SPC") 'just-one-space)))

;; (add-hook 'sml-shell-hook
;;    (lambda ()
;;      (send-string sml-process-name
;;        (concat "use \""
;;                sml-mode-dir
;;                "/inferior-setup.sml\";\n"))))

(provide 'init-sml)
