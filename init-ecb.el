;; ECB configurations
(require-package 'ecb)
(setq semantic-load-turn-everything-on t)
(require 'semantic)
(require 'ecb-autoloads)

;;;; 各窗口间切换
(global-set-key [27 up] 'windmove-up)
(global-set-key [27 down] 'windmove-down)
(global-set-key [27 right] 'windmove-right)
(global-set-key [27 left] 'windmove-left)

;;;; 使某一ecb窗口最大化
(define-key global-map (kbd "C-c . 1") 'ecb-maximize-window-directories)
(define-key global-map (kbd "C-c . 2") 'ecb-maximize-window-sources)
(define-key global-map (kbd "C-c . 3") 'ecb-maximize-window-methods)
(define-key global-map (kbd "C-c . 4") 'ecb-maximize-window-history)

;;;; 隐藏和显示ecb窗口
(define-key global-map (kbd "C-c . 5") 'ecb-hide-ecb-windows)
(define-key global-map (kbd "C-c . 6") 'ecb-show-ecb-windows)

;;;; 恢复原始窗口布局
(define-key global-map (kbd "C-c . 7") 'ecb-restore-default-window-sizes)

(provide 'init-ecb)
