;-------------------------------------------------------------------
;                highlight-symbol
;-------------------------------------------------------------------
(require 'highlight-symbol)
(add-to-list 'load-path "~/.emacs.d/el-get/highlight-symbol")
(require 'highlight-symbol)

(global-set-key (kbd "C-c C-u") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c C-n") 'highlight-symbol-next)
(global-set-key (kbd "C-c C-p") 'highlight-symbol-prev)



(provide 'init-highlight-symbol)
