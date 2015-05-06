(require-package 'yasnippet)
(require 'yasnippet)
(setq yas-root-directory "~/.emacs.d/elpa/yasnippet-20130722.1832/snippets")
(setq my-yasnippet-directory "~/.emacs.d/my-yasnippet")

; (yas-load-directory yas-root-directory)
(setq yas-snippet-dirs (list yas-root-directory my-yasnippet-directory))

(setq yas/prompt-functions '(yas/x-prompt yas/dropdown-prompt))

(yas-global-mode)
(yas-minor-mode-on)

(provide 'init-yasnippet)
