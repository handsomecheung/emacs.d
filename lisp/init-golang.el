(require-package 'go-mode)

(setenv "PATH"
  (concat
   (if *is-a-mac* "/usr/local/go/bin/go" "/usr/lib/go-1.10/bin") ":"
   (concat (getenv "HOME") "/gowork/bin" ":")
   (getenv "PATH")
  )
)

(setenv "GOPATH" (concat (getenv "HOME") "/gowork"))

(defun go-run-buffer()
  (interactive)
  (shell-command (concat "go run " (buffer-name))))

(defun go-kill()
  (interactive)
  (if (go-mode-in-string)
      (paredit-kill-line-in-string)
    (paredit-kill)))

(defun go-backward-delete()
  (interactive)
  (if (go-mode-in-string)
      (paredit-backward-delete-in-string)
    (paredit-backward-delete)))

(setq gofmt-args '("-s"))

(add-hook 'go-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'gofmt-before-save)
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 2)
            (setq indent-tabs-mode 1)
            (linum-mode 1)
            (auto-complete-mode 1)
            ;; (add-to-list 'ac-sources 'ac-source-go)
            ;; (call-process "gocode" nil nil nil "-s")
            ))

;; -----------------------------------
;; golangci-lint
;; -----------------------------------
(require-package 'flycheck-golangci-lint)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(setq flycheck-golangci-lint-executable
      (concat (getenv "GOPATH") "/bin/golangci-lint"))
;; -----------------------------------




(provide 'init-golang)
