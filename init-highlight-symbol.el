;-------------------------------------------------------------------
;                highlight-symbol
;-------------------------------------------------------------------
(require 'highlight-symbol)
(add-to-list 'load-path "~/.emacs.d/el-get/highlight-symbol")
(require 'highlight-symbol)

(global-set-key [(control f4)] 'highlight-symbol-at-point)
(global-set-key [f4] 'highlight-symbol-next)
(global-set-key [(shift f4)] 'highlight-symbol-prev)
;(global-set-key [(meta f4)] 'highlight-symbol-prev)


(provide 'init-highlight-symbol)
