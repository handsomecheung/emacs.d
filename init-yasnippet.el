;(require-package 'yasnippet)
(require 'yasnippet)
(setq yas-root-directory "~/.emacs.d/elpa/yasnippet-20130722.1832/snippets")

(yas-load-directory yas-root-directory)
(setq yas-snippet-dirs yas-root-directory)
(yas-global-mode)
(yas-minor-mode-on)

(provide 'init-yasnippet)
