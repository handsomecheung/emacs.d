(let ((gobin "/usr/local/go/bin"))
  (setenv "PATH"
          (concat
           gobin ":"
           (concat (getenv "HOME") "/gowork/bin" ":")
           (getenv "PATH")
           ))
  (setq exec-path (append exec-path (list gobin))))

(setenv "GOPATH" (concat (getenv "HOME") "/gowork"))

(require-package 'go-mode)

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

;; not setup by default, golangci-lint eats too much memory
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-golangci-lint-setup))

(setq flycheck-golangci-lint-executable
      (concat (getenv "GOPATH") "/bin/golangci-lint"))
;; -----------------------------------




(provide 'init-golang)
