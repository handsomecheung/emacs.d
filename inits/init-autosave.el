(defmacro advise-commands (advice-name commands &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.

The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (before ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

;; advise all window switching functions
(advise-commands "auto-save"
                 (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
                 (prelude-auto-save))


;; (macroexpand '(advise-commands "auto-save"
;;                  (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
;;                  (prelude-auto-save)))

;; (progn
;;   (defadvice switch-to-buffer
;;     (before switch-to-buffer-auto-save activate)
;;     (prelude-auto-save))
;;   (defadvice other-window
;;     (before other-window-auto-save activate)
;;     (prelude-auto-save))
;;   (defadvice windmove-up
;;     (before windmove-up-auto-save activate)
;;     (prelude-auto-save))
;;   (defadvice windmove-down
;;     (before windmove-down-auto-save activate)
;;     (prelude-auto-save))
;;   (defadvice windmove-left
;;     (before windmove-left-auto-save activate)
;;     (prelude-auto-save))
;;   (defadvice windmove-right
;;     (before windmove-right-auto-save activate)
;;     (prelude-auto-save)))

(provide 'init-autosave)
