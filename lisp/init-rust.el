;; -----------------------------------
;; rust-mode
;; -----------------------------------
(require-package 'rust-mode)

(setq rust-format-on-save t)
(add-hook 'rust-mode-hook
          (lambda ()
            (setq indent-tabs-mode nil)
            (let ((bin "~/.cargo/bin"))
              (setenv "PATH" (concat bin ":" (getenv "PATH")))
              (setq exec-path (append exec-path (list bin))))
            ))
;; -----------------------------------

;; -----------------------------------
;; flycheck-rust
;; -----------------------------------
(require-package 'flycheck-rust)

(add-hook 'rust-mode-hook 'flycheck-mode)
(add-hook 'flycheck-mode-hook 'flycheck-rust-setup)
;; -----------------------------------

(provide 'init-rust)
