(require 'yasnippet)
(setq yas-root-directory "~/.emacs.d/elpa/yasnippet-20130505.2115/snippets")

(yas-load-directory yas-root-directory)
(yas-global-mode)
(yas-minor-mode-on)

(provide 'init-yasnippet)
