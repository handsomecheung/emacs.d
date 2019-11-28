(require-package 'pyim)
(require 'pyim)

(require-package 'pyim-basedict)  ; 拼音词库设置
(require 'pyim-basedict)  ; 拼音词库设置

(require-package 'posframe)
(require 'posframe)

(pyim-basedict-enable)
(setq default-input-method "pyim")
(setq pyim-page-tooltip 'posframe)
(setq pyim-default-scheme 'quanpin)
(setq pyim-page-length 9)

(global-set-key (kbd "C-\\") 'toggle-input-method)

(provide 'init-pyim)
