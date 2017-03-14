(require 'cl)

(set-language-environment 'UTF-8)


;; 设置中文字体
(if *is-a-mac*
    (progn
      (set-fontset-font
       (frame-parameter nil 'font)
       'han
       ;; (font-spec :family "Monaco")
       (font-spec :family "Lantinghei SC")
       ;; (font-spec :family "Hiragino Sans GB" )
       ))
  (progn
    ;; (set-default-font "DejaVu Sans Mono")
    ;; (set-fontset-font "fontset-default" 'unicode '("WenQuanYi Bitmap Song" . "unicode-bmp"))
    (set-default-font "WenQuanYi Zen Hei Mono")
    (set-fontset-font "fontset-default" 'unicode '("WenQuanYi Zen Hei Mono" . "unicode-ttf"))))

;; set font size to 18
(set-face-attribute 'default nil :height 180)

(require-package 'zoom-frm)
(require 'zoom-frm)
(global-set-key (kbd "C-x C-0") 'zoom-in/out)
(global-set-key (kbd "C-M-=") 'zoom-in)
(global-set-key (kbd "C-M--") 'zoom-out)

;; --------------------------------------------------------------------------------
;; -- 废弃了，此方法在 Daemon 下会出错，terminal 0 is locked, cannot read from it.
;; -- 使用 zoom-frm 插件
;; --------------------------------------------------------------------------------
(defun sanityinc/font-name-replace-size (font-name new-size)
  (let ((parts (split-string font-name "-")))
    (setcar (nthcdr 7 parts) (format "%d" new-size))
    (mapconcat 'identity parts "-")))

(defun sanityinc/increment-default-font-height (delta)
  "Adjust the default font height by DELTA on every frame.
Emacs will keep the pixel size of the frame approximately the
same.  DELTA should be a multiple of 10, to match the units used
by the :height face attribute."
  (let* ((new-height (+ (face-attribute 'default :height) delta))
         (new-point-height (/ new-height 10)))
    (dolist (f (frame-list))
      (with-selected-frame f
        ;; Latest 'set-frame-font supports a "frames" arg, but
        ;; we cater to Emacs 23 by looping instead.
        (set-frame-font (sanityinc/font-name-replace-size
                         (face-font 'default)
                         new-point-height)
                        t)))
    (set-face-attribute 'default nil :height new-height)
    (message "default font size is now %d" new-point-height)))

(defun sanityinc/increase-default-font-height ()
  (interactive)
  (sanityinc/increment-default-font-height 10))

(defun sanityinc/decrease-default-font-height ()
  (interactive)
  (sanityinc/increment-default-font-height -10))

;; (global-set-key (kbd "C-M-=") 'sanityinc/increase-default-font-height)
;; (global-set-key (kbd "C-M--") 'sanityinc/decrease-default-font-height)
;; --------------------------------------------------------------------------------

(provide 'init-fonts)