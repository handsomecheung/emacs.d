(autoload 'doctest-mode "doctest-mode" "Python doctest editing mode." t)

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
        ("SConscript\\'" . python-mode))
              auto-mode-alist))

;;------------------------------------------------------------
;; python folding
;;------------------------------------------------------------
(add-hook 'python-mode-hook 'hs-minor-mode)
;;------------------------------------------------------------


;;----------------------------------------------------------------------------
;; flycheck config
;;----------------------------------------------------------------------------
(setq flycheck-python-pycompile-executable "/usr/local/bin/python3")
;;----------------------------------------------------------------------------

(provide 'init-python)
