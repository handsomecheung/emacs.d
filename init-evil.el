(require-package 'evil)
(evil-mode 1)
(setq evil-default-cursor t)
(define-key evil-emacs-state-map (kbd "C-.") 'evil-execute-in-normal-state)

; 设置使用C-d作为ESC按键
;; (define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state)
;; (define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state)
;; (define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state)
;; (define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state)
;; (define-key evil-normal-state-map "t" 'evil-use-register)

;;; (setq evil-default-state 'emacs)
(provide 'init-evil)
