;(require-package 'yasnippet)
(require 'yasnippet)
(setq yas-root-directory "~/.emacs.d/elpa/yasnippet-20130907.1855/snippets")

(yas-load-directory yas-root-directory)
(setq yas-snippet-dirs yas-root-directory)
(yas-global-mode)
(yas-minor-mode-on)

(provide 'init-yasnippet)
