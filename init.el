;;; init.el ---- Emacs Config Entrypoint

;;; Commentary:
; forked from https://github.com/purcell/emacs.d

;;; This file bootstraps the configuration, which is divided into
;;; a number of other files.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;;; Code:

(package-initialize)

(if (not (boundp 'user-emacs-directory))
    (setq user-emacs-directory "~/.emacs.d/"))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

(add-to-list 'load-path
             (concat user-emacs-directory
                     (convert-standard-filename "package/")))
(add-to-list 'custom-theme-load-path
             (concat user-emacs-directory
                     (convert-standard-filename "themes/")))

;; (add-to-list 'load-path "~/emacs.d/packages/tiny-tools")
(require 'init-benchmarking) ;; Measure startup time

;;----------------------------------------------------------------------------
;; Which functionality to enable (use t or nil for true and false)
;;----------------------------------------------------------------------------
(defconst *spell-check-support-enabled* nil)
(defconst *is-a-mac* (eq system-type 'darwin))
(defconst *is-carbon-emacs* (eq window-system 'mac))
(defconst *is-cocoa-emacs* (and *is-a-mac* (eq window-system 'ns)))

;; (setq debug-on-error t)
;; (setq eval-expression-debug-on-error t)
;;----------------------------------------------------------------------------
;; Bootstrap config
;;----------------------------------------------------------------------------
(require 'init-common-function)
(require 'init-compat)
(require 'init-utils)
(require 'init-site-lisp) ;; Must come before elpa, as it may provide package.el
(require 'init-elpa)      ;; Machinery for installing required packages
;(require 'init-elget)
(require 'init-exec-path) ;; Set up $PATH

;;----------------------------------------------------------------------------
;; Load configs for specific features and modes
;;----------------------------------------------------------------------------

(require-package 'wgrep)
(require-package 'diminish)
(require-package 'scratch)
(require-package 'command-log-mode)

(require 'init-evil)
(require 'init-frame-hooks)
(require 'init-xterm)
(require 'init-git)
(require 'init-mode-line)
(require 'init-themes)
(require 'init-osx-keys)
(require 'init-gui-frames)
(require 'init-maxframe)
(require 'init-proxies)
(require 'init-dired)
(require 'init-ido)
(require 'init-isearch)
(require 'init-uniquify)
(require 'init-ibuffer)
(require 'init-flycheck)
(require 'init-highlight-symbol)
(require 'init-project)
(require 'init-hide-region)
(require 'init-shell)
(require 'init-ace-jump)
(require 'init-folding)
(require 'init-screenshot)

;; (require 'init-autosave)
;; (require 'init-region)
;; (require 'init-icicles)

(require 'init-recentf)
(require 'init-hippie-expand)
(require 'init-auto-complete)
(require 'init-yasnippet)
(require 'init-windows)
(require 'init-fonts)
(require 'init-mmm)
(require 'init-editing-utils)
(require 'init-darcs)
(require 'init-comment)
(require 'init-copy-cut-yank)
(require 'init-autopair)
(require 'init-quickrun)

;; (require 'init-sessions)
;; (require 'init-smartparens)
;; (require 'init-ecb)
;; (require 'init-present)

(require 'init-markdown)
(require 'init-javascript)
(require 'init-css)
(require 'init-python)
(require 'init-lua)
(require 'init-ruby)
(require 'init-rails)
(require 'init-sql)
(require 'init-golang)
(require 'init-paredit)
(require 'init-lisp)
(require 'init-scheme)
(require 'init-haskell)
(require 'init-json)
(require 'init-restclient)
(require 'init-groovy)
(require 'init-vue)
(require 'init-haskell)
(require 'init-scala)
(require 'init-ocaml)
(require 'init-sml)
(require 'init-common-lisp)

;; (require 'init-crontab)
;; (require 'init-textile)
;; (require 'init-csv)
;; (require 'init-erlang)
;; (require 'init-php)
;; (require 'init-org)
;; (require 'init-nxml)
;; (require 'init-haml)
;; (require 'init-prolog)
;; (require 'init-slime)
;; (require 'init-clojure)


(when *spell-check-support-enabled*
  (require 'init-spelling))

(require 'init-misc)

;; (require 'init-tap4fun)

;; Extra packages which don't require any configuration

(require-package 'gnuplot)
(require-package 'htmlize)
(require-package 'dsvn)
(when *is-a-mac*
  (require-package 'osx-location))
(require-package 'regex-tool)

;;----------------------------------------------------------------------------
;; Allow access from emacsclient
;;----------------------------------------------------------------------------
(require 'server)
(unless (server-running-p)
  (server-start))


;;----------------------------------------------------------------------------
;; Variables configured via the interactive 'customize' interface
;;----------------------------------------------------------------------------
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))


;;----------------------------------------------------------------------------
;; Allow users to provide an optional "init-local" containing personal settings
;;----------------------------------------------------------------------------
(require 'init-local nil t)


;;----------------------------------------------------------------------------
;; Locales (setting them earlier in this file doesn't work in X)
;;----------------------------------------------------------------------------
(require 'init-locales)

(require 'init-pyim)   ;; pyim must be enabled in the end

;; Local Variables:
;; coding: utf-8
;; no-byte-compile: t
;; End:
(put 'set-goal-column 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;;; init.el ends here
