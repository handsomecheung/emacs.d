(global-set-key (kbd "S-SPC") 'toggle-fcitx)

(defun toggle-fcitx ()
  "toggle fcitx by fcitx-remote, draft.
fcitx-remote don't work fine in Emacs GUI"
  (let* ((cmd "fcitx-remote")
         (fcitx-state (shell-command-to-string cmd))
         (if (= fcitx-state 1)
             (shell-command (concat cmd " -c"))
             (shell-command (concat cmd " -o"))))))

(provide 'init-fcitx.el)
