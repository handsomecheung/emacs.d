(require-package 'sql-indent)
(eval-after-load 'sql
  '(load-library "sql-indent"))

(eval-after-load 'sql
  '(when (package-installed-p 'dash-at-point)
     (defun sanityinc/maybe-set-dash-db-docset ()
       (when (eq sql-product 'postgres)
         (setq dash-at-point-docset "psql")))

     (add-hook 'sql-mode-hook 'sanityinc/maybe-set-dash-db-docset)
     (add-hook 'sql-interactive-mode-hook 'sanityinc/maybe-set-dash-db-docset)
     (defadvice sql-set-product (after set-dash-docset activate)
       (sanityinc/maybe-set-dash-db-docset))))

(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
        (rval 'sql-product))
    (if (symbol-value rval)
        (let* ((dir-name "~/.emacs.d/sql/") (filename
                  (concat dir-name
                          (symbol-name (symbol-value rval))
                          "-history.sql")))
          (progn (make-directory dir-name 1) (set (make-local-variable lval) filename)))
      (error
       (format "SQL history will not be saved because %s is nil"
               (symbol-name rval))))))

(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

(defun sql-db (product server user passwd db port)
  (let ((sql-product product)
        (sql-server server)
        (sql-user user)
        (sql-password passwd)
        (sql-database db)
        (sql-port port))
    (flet ((sql-get-login (&rest what)))
      (sql-product-interactive sql-product))))

(add-to-list 'same-window-regexps "\\*SQL\\*")

(require 'sql-completion)
(setq sql-interactive-mode-hook
      (lambda ()
        (define-key sql-interactive-mode-map "\t" 'comint-dynamic-complete)
        (sql-mysql-completion-init)))

;; -----------------------------------------------------
;; sql transform
;; -----------------------------------------------------
(require 'sql-transform)

(define-key sql-mode-map (kbd "C-c u") 'sql-to-update)
(define-key sql-mode-map (kbd "C-c s") 'sql-to-select)
(define-key sql-mode-map (kbd "C-c i") 'sql-to-insert)
(define-key sql-mode-map (kbd "C-c d") 'sql-to-delete)

(define-key sql-interactive-mode-map (kbd "C-c u") 'sql-to-update)
(define-key sql-interactive-mode-map (kbd "C-c s") 'sql-to-select)
(define-key sql-interactive-mode-map (kbd "C-c i") 'sql-to-insert)
(define-key sql-interactive-mode-map (kbd "C-c d") 'sql-to-delete)

;; -----------------------------------------------------

;; (setq sql-connection-alist
;; '((pool-a
;; (sql-product 'mysql)
;; (sql-server "127.0.0.1")
;; (sql-user "root")
;; (sql-password "")
;; (sql-database "heros")
;; (sql-port 3306))
;; (pool-b
;; (sql-product 'mysql)
;; (sql-server "127.0.0.1")
;; (sql-user "root")
;; (sql-password "")
;; (sql-database "world_wars")
;; (sql-port 3306))))

;; (defun sql-connect-preset (name)
;;   "Connect to a predefined SQL connection listed in `sql-connection-alist'"
;;   (eval `(let ,(cdr (assoc name sql-connection-alist))
;;     (flet ((sql-get-login (&rest what)))
;;       (sql-product-interactive sql-product)))))

;; (defun sql-pool-a ()
;;   (interactive)
;;   (sql-connect-preset 'pool-a))

(provide 'init-sql)
