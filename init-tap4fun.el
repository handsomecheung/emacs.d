(require 'netrc)

(defun t4f-db-user ()
  "get db analysis username by .netrc"
  (netrc-get (netrc-machine (netrc-parse "~/.netrc") "db_analysis.tap4fun.com") "login"))

(defun t4f-db-passwd ()
  "get db analysis username by .netrc"
  (netrc-get (netrc-machine (netrc-parse "~/.netrc") "db_analysis.tap4fun.com") "password"))

(defun t4f-parse-server (server-str)
  "get server name, ip, port by server str"
  (let* ((item-list (split-string server-str ":::"))
         (name (nth 1 item-list))
         (ip (t4f-parse-ip (nth 2 item-list)))
         (port (t4f-parse-port (nth 2 item-list)))
         (db (t4f-parse-ke-db port))
         (servers))
    (progn
      (setq servers (make-hash-table :test 'equal))
      (puthash "name" name servers)
      (puthash "ip" ip servers)
      (puthash "port" port servers)
      (puthash "db" db servers)
      servers)))

(defun t4f-parse-ip (url)
  "get ip by url"
  (replace-regexp-in-string "/" "" (nth 1 (split-string url ":"))))

(defun t4f-parse-port (url)
  "get port by url"
  (let* ((item2 (nth 2 (split-string url ":")))
         (port (if (equal item2 nil) 80
                 (string-to-number (replace-regexp-in-string "/" "" item2)))))
    port))

(defun t4f-parse-ke-db (port)
  "get default ke db by port"
  (cond ((= port 90) "kings_2")
        ((= port 92) "kings_3")
        ((= port 94) "kings_4")
        ((= port 99) "gateway")
        (t "kings")))

(defun t4f-show-server-list (server-list)
  "show server list in tmp buffer"
  (let ((buffer-name "*t4f-server-list*"))
    (progn (get-buffer-create buffer-name)
           (switch-to-buffer buffer-name)
           (erase-buffer)
           (insert-list-newline server-list))))

;; (defun t4f-get-raw-server-str (key-word)
;;   "get server list string using shell cmd with given key word"
;;   (replace-regexp-in-string "\\\\n" "\n"
;;                             (replace-regexp-in-string "\\\\n\n$" ""
;;                              (shell-command-to-string
;;                               (concat "zsh ~/tap4fun/script/ke-server-list.sh "
;;                                       key-word)))))

(defun t4f-get-raw-server-str (key-word)
  "get server list string using shell cmd with given key word"
  (replace-regexp-in-string "\n$" ""
                            (shell-command-to-string
                             (concat "zsh ~/tap4fun/script/ke-server-list.sh "
                                     key-word))))

(defun t4f-get-raw-server-list (key-word)
  "get server list"
  (split-string (t4f-get-raw-server-str key-word) "\n"))

(defun t4f-choose-server (key-word)
  "select server list from gateway, using a shell script"
  (let* ((i 1)
         (server-list
          (map 'list (lambda (s)
                       (let ((s (trim-string s)))
                         (if (not (equal s ""))
                             (prog1
                                 (concat (number-to-string i) "::: " (trim-string s))
                               (setq i (+ i 1))))))
               (t4f-get-raw-server-list key-word))))
    (progn
      (t4f-show-server-list server-list)
      (t4f-parse-server
       (get-line-string (if (= (length server-list) 1) 1
                            (string-to-number
                             (read-string "Choose a Server: "))))))))

(defun t4f-exit-exist-sqli-buffer ()
  "exit exist the default SQLi buffer."
  (if (fboundp 'sql-set-product)
      (progn
        (sql-set-product 'mysql)
        (let ((default-buffer (sql-find-sqli-buffer)))
          (if (not (null default-buffer))
              (progn
                (setq sql-buffer default-buffer)
                (run-hooks 'sql-set-sqli-hook)
                (sql-send-string "exit")
                (sleep-for 2)))))))

(defun t4f-ke-mysql (key-word)
  "connect ke's mysql, choose a server"
  (interactive "sEnter key word to Connect: \n")
  (let* ((servers (t4f-choose-server key-word))
         ;; (name (gethash "name" servers))
         (ip (gethash "ip" servers))
         (default-db (gethash "db" servers))
         (db-user (t4f-db-user))
         (db-passwd (t4f-db-passwd)))
    (progn
      (t4f-exit-exist-sqli-buffer)
      (sql-db 'mysql ip db-user db-passwd default-db 3306))))

;;; (sql-db 'mysql "54.200.53.230" (t4f-db-user) (t4f-db-passwd) "kings" 3306)

(provide 'init-tap4fun)
