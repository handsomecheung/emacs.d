(require-package 'go-mode)

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 2)
            (setq indent-tabs-mode nil)))

(provide 'init-go)
