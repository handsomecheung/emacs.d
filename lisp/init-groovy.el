(require-package 'groovy-mode)

(setq auto-mode-alist (append '(("Jenkinsfile" . groovy-mode))
                              auto-mode-alist))

(provide 'init-groovy)
