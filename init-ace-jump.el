(require-package 'ace-jump-mode)
(require-package 'ace-jump-buffer)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;;If you also use viper mode:
;; (define-key viper-vi-global-user-map (kbd "SPC") 'ace-jump-mode)
(provide 'init-ace-jump)
