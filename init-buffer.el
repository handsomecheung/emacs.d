;----------swbuff----------------------------------------
(require-package 'swbuff)
;; (global-set-key (kbd "") 'swbuff-switch-to-previous-buffer)
;; (global-set-key (kbd "") 'swbuff-switch-to-next-buffer)

(setq swbuff-exclude-buffer-regexps
     '("^ " "\\*.*\\*"))

(setq swbuff-status-window-layout 'scroll)
(setq swbuff-clear-delay 1)
(setq swbuff-separator "|")
(setq swbuff-window-min-text-height 1)
;;--------------------------------------------------------------------------------

;--------------------tabbar--------------------------------------------------
;; (require-package 'tabbar)
;; (tabbar-mode)
;; (global-set-key (kbd "") 'tabbar-backward-group)
;; (global-set-key (kbd "") 'tabbar-forward-group)
;; (global-set-key (kbd "") 'tabbar-backward)
;; (global-set-key (kbd "") 'tabbar-forward)
;--------------------------------------------------------------------------------
(provide 'init-buffer)
