(require 'screenshot)
(setq screenshot-schemes              ; edit as you like
      '(
        ;; To local image directory
        ("local"
         :dir "~/")            ; Image repository directory
        ;; To current directory
        ("current-directory"          ; No need to modify
         :dir default-directory)
        ;; To remote ssh host
        ("remote-ssh"
         :dir "/tmp/"                 ; Temporary saved directory
         :ssh-dir "www.example.org:public_html/archive/" ; SSH path
         :url "http://www.example.org/archive/")  ; Host URL prefix
        ;; To EmacsWiki (need yaoddmuse.el)
        ("EmacsWiki"                 ; Emacs users' most familiar Oddmuse wiki
         :dir "~/.yaoddmuse/EmacsWiki/"  ; same as yaoddmuse-directory
         :yaoddmuse "EmacsWiki")         ; You can specify another Oddmuse Wiki
        ;; To local web server
        ("local-server"
         :dir "~/public_html/"           ; local server directory
         :url "http://127.0.0.1/")))     ; local server URL prefix
(setq screenshot-default-scheme "local") ; default scheme is "local"

(provide 'init-screenshot)
