;; (require-package 'go-mode)
;; (require 'go-mode)
(require 'go-mode-autoloads)

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

(add-hook 'go-mode-hook
          (lambda ()
            (linum-mode 1)
            (flymake-mode 1)
            (auto-complete-mode 1)
            ;; (add-to-list 'ac-sources 'ac-source-go)
            ;; (call-process "gocode" nil nil nil "-s")
            ))

(add-hook 'go-mode-hook
          (lambda ()
            ;; (add-hook 'before-save-hook 'gofmt-before-save)
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 2)
            (setq indent-tabs-mode nil)))

;;; ### Golang ###
;; (lazy-unset-key
;;  '("C-k" "M-o")
;;  go-mode-map)
;; (lazy-set-key
;;  '(
;;    ("C-c C-c" . go-run-buffer)
;;    ("C-c C-f" . gofmt)
;;    ("C-c C-d" . godoc)
;;    ("C-c C-a" . go-import-add)
;;    ("C-8" . godef-jump)
;;    ("C-u C-8" . godef-jump-other-window)
;;    ("C-k" . go-kill)
;;    ("M-o" . go-backward-delete)
;;    )
;;  go-mode-map
;;  )

(provide 'init-golang)
