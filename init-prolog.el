(add-hook 'prolog-mode-hook
          (lambda ()
            (setq prolog-system 'gprolog)))

(setq auto-mode-alist (append '(("\\.pro$" . prolog-mode))
                              auto-mode-alist))

(provide 'init-prolog)
