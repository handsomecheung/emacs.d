(require-package 'evil)
(evil-mode 1)
(setq evil-default-cursor t)
(define-key evil-emacs-state-map (kbd "C-.") 'evil-execute-in-normal-state)
;;(require 'init-evil-mode-line)
; 设置使用C-d作为ESC按键
;; (define-key evil-insert-state-map (kbd "C-d") 'evil-change-to-previous-state)
;; (define-key evil-normal-state-map (kbd "C-d") 'evil-force-normal-state)
;; (define-key evil-replace-state-map (kbd "C-d") 'evil-normal-state)
;; (define-key evil-visual-state-map (kbd "C-d") 'evil-exit-visual-state)
;; (define-key evil-normal-state-map "t" 'evil-use-register)

;;; (setq evil-default-state 'emacs)

;; -------------------------------------------------------------------------------------------------------------
;;                 AceJump Config
;; -------------------------------------------------------------------------------------------------------------
;; AceJump integration is now included in evil, this gist is only preserved for historical reasons.
;; Please use the provided integration (it's far more advanced)

;; AceJump is a nice addition to evil's standard motions.

;; The following definitions are necessary to define evil motions for ace-jump-mode (version 2).

;; ace-jump is actually a series of commands which makes handling by evil
;; difficult (and with some other things as well), using this macro we let it
;; appear as one.

(defmacro evil-enclose-ace-jump (&rest body)
  `(let ((old-mark (mark))
         (ace-jump-mode-scope 'window))
     (remove-hook 'pre-command-hook #'evil-visual-pre-command t)
     (remove-hook 'post-command-hook #'evil-visual-post-command t)
     (unwind-protect
         (progn
           ,@body
           (recursive-edit))
       (if (evil-visual-state-p)
           (progn
             (add-hook 'pre-command-hook #'evil-visual-pre-command nil t)
             (add-hook 'post-command-hook #'evil-visual-post-command nil t)
             (set-mark old-mark))
         (push-mark old-mark)))))

(evil-define-motion evil-ace-jump-char-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)))

(evil-define-motion evil-ace-jump-line-mode (count)
  :type line
  (evil-enclose-ace-jump
   (ace-jump-mode 9)))

(evil-define-motion evil-ace-jump-word-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 1)))

(evil-define-motion evil-ace-jump-char-To-mode (count)
  :type exclusive
  (evil-enclose-ace-jump
   (ace-jump-mode 5)
   (forward-char -1)))

(add-hook 'ace-jump-mode-end-hook 'exit-recursive-edit)

;; some proposals for binding:

(define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode)
(define-key evil-motion-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
(define-key evil-motion-state-map (kbd "S-SPC") #'evil-ace-jump-line-mode)

(define-key evil-operator-state-map (kbd "SPC") #'evil-ace-jump-char-mode) ; similar to f
(define-key evil-operator-state-map (kbd "C-SPC") #'evil-ace-jump-word-mode)
(define-key evil-operator-state-map (kbd "S-SPC") #'evil-ace-jump-line-mode)
;; (define-key evil-operator-state-map (kbd "C-SPC") #'evil-ace-jump-char-to-mode) ; similar to t
;; (define-key evil-operator-state-map (kbd "M-SPC") #'evil-ace-jump-word-mode)

;; different jumps for different visual modes
;; (defadvice evil-visual-line (before spc-for-line-jump activate)
;;   (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-line-mode))

;; (defadvice evil-visual-char (before spc-for-char-jump activate)
;;   (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode))

;; (defadvice evil-visual-block (before spc-for-char-jump activate)
;;   (define-key evil-motion-state-map (kbd "SPC") #'evil-ace-jump-char-mode))
;; -------------------------------------------------------------------------------------------------------------


;; -------------------------------------------------------------------------------------------------------------
;; code folding binding:
;; already on evil
;; -------------------------------------------------------------------------------------------------------------
;; (define-key evil-motion-state-map (kbd "zc") #'hs-hide-block)
;; (define-key evil-motion-state-map (kbd "zm") #'hs-hide-all)
;; (define-key evil-motion-state-map (kbd "zo") #'hs-show-block)
;; (define-key evil-motion-state-map (kbd "zr") #'hs-show-all)
;; (define-key evil-motion-state-map (kbd "zt") #'hs-show-all)
;; -------------------------------------------------------------------------------------------------------------

(provide 'init-evil)
