;;----------------------------------------------------------------------------
;; Navigate window layouts with "C-c <left>" and "C-c <right>"
;;----------------------------------------------------------------------------
(winner-mode 1)


;;----------------------------------------------------------------------------
;; When splitting window, show (other-buffer) in the new window
;;----------------------------------------------------------------------------
(defun split-window-func-with-other-buffer (split-function)
  (lexical-let ((s-f split-function))
    (lambda ()
      (interactive)
      (funcall s-f)
      (set-window-buffer (next-window) (other-buffer)))))

(global-set-key "\C-x2" (split-window-func-with-other-buffer 'split-window-vertically))
(global-set-key "\C-x3" (split-window-func-with-other-buffer 'split-window-horizontally))


;;----------------------------------------------------------------------------
;; Rearrange split windows
;;----------------------------------------------------------------------------
(defun split-window-horizontally-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-horizontally))))

(defun split-window-vertically-instead ()
  (interactive)
  (save-excursion
    (delete-other-windows)
    (funcall (split-window-func-with-other-buffer 'split-window-vertically))))

(global-set-key "\C-x|" 'split-window-horizontally-instead)
(global-set-key "\C-x_" 'split-window-vertically-instead)


;; --------------------------------------------------------------------------------
(defun split-window-4()
  "Splite window into 4 sub-window"
  (interactive)
  (if (= 1 (length (window-list)))
      (progn (split-window-vertically)
             (split-window-horizontally)
             (other-window 2)
             (split-window-horizontally)
             )
    )
  )

(defun split-window-3()
  "Splite window into 3 sub-window"
  (interactive)
  (if (= 1 (length (window-list)))
      (progn (split-window-vertically)
             (split-window-horizontally)
             )
    )
  )

(global-set-key (kbd "C-x 4 4") 'split-window-4)
(global-set-key (kbd "C-x 4 3") 'split-window-3)


;  +----------------------+                 +------------+-----------+
;  |                      |           \     |            |           |
;  |                      |   +-------+\    |            |           |
;  +----------+-----------+   +-------+/    |            +-----------+
;  |          |           |           /     |            |           |
;  |          |           |                 |            |           |
;  +----------+-----------+                 +------------+-----------+

(defun split-v-3 ()
  "Change 3 window style from horizontal to vertical"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
        (let ((1stBuf (window-buffer (car winList)))
              (2ndBuf (window-buffer (car (cdr winList))))
              (3rdBuf (window-buffer (car (cdr (cdr winList))))))
          (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

          (delete-other-windows)
          (split-window-horizontally)
          (set-window-buffer nil 1stBuf)
          (other-window 1)
          (set-window-buffer nil 2ndBuf)
          (split-window-vertically)
          (set-window-buffer (next-window) 3rdBuf)
          (select-window (get-largest-window))
          ))))


;  +------------+-----------+                  +----------------------+
;  |            |           |            \     |                      |
;  |            |           |    +-------+\    |                      |
;  |            +-----------+    +-------+/    +----------+-----------+
;  |            |           |            /     |          |           |
;  |            |           |                  |          |           |
;  +------------+-----------+                  +----------+-----------+


(defun split-h-3 ()
 "Change 3 window style from vertical to horizontal"
 (interactive)

 (select-window (get-largest-window))
 (if (= 3 (length (window-list)))
     (let ((winList (window-list)))
       (let ((1stBuf (window-buffer (car winList)))
         (2ndBuf (window-buffer (car (cdr winList))))
         (3rdBuf (window-buffer (car (cdr (cdr winList))))))
        (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

        (delete-other-windows)
        (split-window-vertically)
        (set-window-buffer nil 1stBuf)
        (other-window 1)
        (set-window-buffer nil 2ndBuf)
        (split-window-horizontally)
        (set-window-buffer (next-window) 3rdBuf)
        (select-window (get-largest-window))
         ))))



;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  +------------+-----------+    +-------+/   +------------+           |
;  |                        |            /    |            |           |
;  |                        |                 |            |           |
;  +------------+-----------+                 +------------+-----------+
;  +------------+-----------+                 +------------+-----------+
;  |            |           |            \    |            |           |
;  |            |           |    +-------+\   |            |           |
;  |            +-----------+    +-------+/   +------------+-----------+
;  |            |           |            /    |                        |
;  |            |           |                 |                        |
;  +------------+-----------+                 +------------+-----------+

 (defun change-split-type-3 ()
  "Change 3 window style from horizontal to vertical and vice-versa"
  (interactive)

  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
            (let ((1stBuf (window-buffer (car winList)))
                  (2ndBuf (window-buffer (car (cdr winList))))
                  (3rdBuf (window-buffer (car (cdr (cdr winList)))))

                  (split-3
                   (lambda(1stBuf 2ndBuf 3rdBuf split-1 split-2)
                     "change 3 window from horizontal to vertical and vice-versa"
                     (message "%s %s %s" 1stBuf 2ndBuf 3rdBuf)

                     (delete-other-windows)
                     (funcall split-1)
                     (set-window-buffer nil 2ndBuf)
                     (funcall split-2)
                     (set-window-buffer (next-window) 3rdBuf)
                     (other-window 2)
                     (set-window-buffer nil 1stBuf)))

                  (split-type-1 nil)
                  (split-type-2 nil)
                  )
              (if (= (window-width) (frame-width))
                  (setq split-type-1 'split-window-horizontally
                        split-type-2 'split-window-vertically)
                (setq split-type-1 'split-window-vertically
               split-type-2 'split-window-horizontally))
              (funcall split-3 1stBuf 2ndBuf 3rdBuf split-type-1 split-type-2)

 ))))

(global-set-key (kbd "C-x 4 3") (quote change-split-type-3))


;  +------------+-----------+                   +------------+-----------+
;  |            |     C     |            \      |            |     A     |
;  |            |           |    +-------+\     |            |           |
;  |     A      |-----------|    +-------+/     |     B      |-----------|
;  |            |     B     |            /      |            |     C     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+
;
;  +------------------------+                   +------------------------+
;  |           A            |           \       |           B            |
;  |                        |   +-------+\      |                        |
;  +------------+-----------+   +-------+/      +------------+-----------+
;  |     B      |     C     |           /       |     C      |     A     |
;  |            |           |                   |            |           |
;  +------------+-----------+                   +------------+-----------+


(defun roll-v-3 (&optional arg)
  "Rolling 3 window buffers (anti-)clockwise"
  (interactive "P")
  (select-window (get-largest-window))
  (if (= 3 (length (window-list)))
      (let ((winList (window-list)))
        (let ((1stWin (car winList))
              (2ndWin (car (cdr winList)))
              (3rdWin (car (last winList))))
          (let ((1stBuf (window-buffer 1stWin))
                (2ndBuf (window-buffer 2ndWin))
                (3rdBuf (window-buffer 3rdWin)))
            (if arg (progn
                                        ; anti-clockwise
                      (set-window-buffer 1stWin 3rdBuf)
                      (set-window-buffer 2ndWin 1stBuf)
                      (set-window-buffer 3rdWin 2ndBuf))
              (progn                                      ; clockwise
                (set-window-buffer 1stWin 2ndBuf)
                (set-window-buffer 2ndWin 3rdBuf)
                (set-window-buffer 3rdWin 1stBuf))
              ))))))

(global-set-key (kbd "C-c r")  (quote roll-v-3))

;; --------------------------------------------------------------------------------





(require-package 'window-number)
(autoload 'window-number-mode "window-number"
  "A global minor mode that enables selection of windows according to
numbers with the C-x C-j prefix.  Another mode,
`window-number-meta-mode' enables the use of the M- prefix."
  t)

(autoload 'window-number-meta-mode "window-number"
  "A global minor mode that enables use of the M- prefix to select
windows, use `window-number-mode' to display the window numbers in
the mode-line."
  t)

(window-number-mode 1)
(window-number-meta-mode 1)


(winner-mode 1)
;; copied from http://puntoblogspot.blogspot.com/2011/05/undo-layouts-in-emacs.html
(global-set-key (kbd "C-x 4 u") 'winner-undo)
(global-set-key (kbd "C-x 4 r") 'winner-redo)

(require-package 'buffer-move)
(global-set-key (kbd "C-c C-v C-k")     'buf-move-up)
(global-set-key (kbd "C-c C-v C-j")   'buf-move-down)
(global-set-key (kbd "C-c C-v C-h")   'buf-move-left)
(global-set-key (kbd "C-c C-v C-l")  'buf-move-right)


(provide 'init-windows)
