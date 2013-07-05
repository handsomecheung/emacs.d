;; (require 'folding)

;;------------------------------semantic-tag-folding----------------------------------------
(semantic-mode 1)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(load-file "package/semantic-tag-folding.el")
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C-c , -") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c , =") 'semantic-tag-folding-show-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c . -") 'semantic-tag-folding-fold-all)
(define-key semantic-tag-folding-mode-map (kbd "C-c . =") 'semantic-tag-folding-show-all)

;;--------------------------------------------------------------------------------

(provide 'init-folding)
