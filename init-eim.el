(add-to-list 'load-path "~/.emacs.d/package/eim")

(autoload 'eim-use-package "eim" "Another emacs input method")
;; Tooltip 暂时还不好用
(setq eim-use-tooltip nil)

;; (register-input-method
;;  "eim-wb" "euc-cn" 'eim-use-package
;;  "五笔" "汉字五笔输入法" "wb.txt")
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "汉字拼音输入法" "py.txt")

;; 用 ; 暂时输入英文
;(require 'eim-extra)
;(global-set-key ";" 'eim-insert-ascii)

(autoload 'eim-use-package "eim" "chinese-py")
;;(setq eim-punc-translate-p nil)         ; use English punctuation
;; (set-input-method "eim-py")             ; use Pinyin input method
;; (setq activate-input-method t)          ; active input method
;;; (setq default-input-method "eim-py")
;;; (set input-activate nil)

;; (add-hook 'eim-active-hook
;;           (lambda ()
;;             (define-key eim-mode-map "," 'eim-previous-page)
;;             (define-key eim-mode-map "." 'eim-next-page)))

;; (set input-activate nil)
;(add-hook 'find-file-hook
          ;(lambda ()(progn (set-input-method 'eim-py)
                           ;(if (and (boundp input-activate) (eq input-activate t)) (set input-activate nil)))))
(provide 'init-eim)
