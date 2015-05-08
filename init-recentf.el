(recentf-mode 1)
(setq recentf-max-saved-items 1000
      recentf-exclude '("/tmp/" "/ssh:"))
(global-set-key (kbd "C-x C-h") 'recentf-open-files)

(provide 'init-recentf)
