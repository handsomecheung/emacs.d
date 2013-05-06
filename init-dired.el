(require-package 'dired+)

(eval-after-load 'dired
  '(progn
     (require 'dired+)
     (setq dired-recursive-deletes 'top)
     (define-key dired-mode-map [mouse-2] 'dired-find-file)))


;------------dired mode sort------------------------------------
; s s 按照文件大小排序。
; s x 按照文件扩展名排序。
; s t 按照文件访问时间排序。
; s b 按照文件名称的字母顺序排序。
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (make-local-variable  'dired-sort-map)
  (setq dired-sort-map (make-sparse-keymap))
  (define-key dired-mode-map "s" dired-sort-map)
  (define-key dired-sort-map "s"
              '(lambda () "sort by Size"
                (interactive) (dired-sort-other (concat dired-listing-switches "S"))))
  (define-key dired-sort-map "x"
              '(lambda () "sort by eXtension"
                 (interactive) (dired-sort-other (concat dired-listing-switches "X"))))
  (define-key dired-sort-map "t"
              '(lambda () "sort by Time"
                 (interactive) (dired-sort-other (concat dired-listing-switches "t"))))
  (define-key dired-sort-map "n"
              '(lambda () "sort by Name"
                 (interactive) (dired-sort-other (concat dired-listing-switches ""))))))

;目录在前面
(defun sof/dired-sort ()
  "Dired sort hook to list directories first."
  (save-excursion
    (let (buffer-read-only)
      (forward-line 2) ;; beyond dir. header
      (sort-regexp-fields t "^.*$" "[ ]*." (point) (point-max))))
  (and (featurep 'xemacs)
       (fboundp 'dired-insert-set-properties)
       (dired-insert-set-properties (point-min) (point-max)))
  (set-buffer-modified-p nil))
(add-hook 'dired-after-readin-hook 'sof/dired-sort)

;; C-x C-j open the directory of current buffer
(global-set-key (kbd "C-x C-j")
                (lambda ()
                  (interactive)
                  (if (buffer-file-name)
                      (dired default-directory))))

;快速打开父目录
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "<M-up>" )
    'dired-up-directory)
  (define-key dired-mode-map (kbd "ESC <up>" ) 'dired-up-directory)))

;M-o 过滤不想看到的文件
(setq dired-omit-extensions '("CVS/" ".o" "~" ".jpg" ".gif" ".png" "pyc"))

;还可以用 M-x dired-omit-expunge 用来 regexp 过滤文件。
(add-hook 'dired-mode-hook (lambda ()
  (interactive)
  (define-key dired-mode-map (kbd "/")  'dired-omit-expunge)))

;-----------------------------------------------------------------------------

(provide 'init-dired)
