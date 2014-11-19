(require-package 'flymake-shell)
(add-hook 'sh-set-shell-hook 'flymake-shell-load)


;; (setq shell-file-name "/bin/zsh")
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)


(defun kill-shell-buffer(process event)
  "The one actually kill shell buffer when exit. "
  (kill-buffer (process-buffer process))
  )

(defun kill-shell-buffer-after-exit()
  "kill shell buffer when exit."
  (set-process-sentinel (get-buffer-process (current-buffer))
                        'kill-shell-buffer)
  )

(add-hook 'shell-mode-hook 'kill-shell-buffer-after-exit t)




(defun rename-buffer-in-ssh-login (cmd)
  "Rename buffer to the destination hostname in ssh login"
  (if (string-match "ssh [-_a-z0-9A-Z]+@[-_a-z0-9A-Z.]+[ ]*[^-_a-z0-9-A-Z]*$" cmd)
      (let (( host (nth 2 (split-string cmd "[ @\n]" t) )))
        (rename-buffer (concat "*" host)) ;
        (add-to-list 'shell-buffer-name-list (concat "*" host));
        (message "%s" shell-buffer-name-list)
        )
    )
  )
;; (add-hook 'comint-input-filter-functions 'rename-buffer-in-ssh-login)

;; (setq outline-regexp "handsomecheung@tap4fun-mini.*")
(global-set-key (kbd "C-c s") 'shell)

(provide 'init-shell)
