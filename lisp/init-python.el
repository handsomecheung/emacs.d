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
(setq flycheck-python-pycompile-executable (if *is-a-mac* "/usr/locla/bin/python3" "/usr/bin/python3"))

;; pip3 install flake8 pylint mypy
(custom-set-variables
 '(flycheck-python-flake8-executable "python3")
 '(flycheck-python-pycompile-executable "python3")
 '(flycheck-python-pylint-executable "python3"))

;; (add-hook 'python-mode-hook 'flycheck-mode)
(setq flycheck-flake8rc "~/.flake8")

;; You can set the path to your flake8 configuration with:  (setq flycheck-flake8rc "/path/to/your/flake8-config-file")

;; As for enabling there are different ways of doing it I prefer to use an add-hook like so: (add-hook 'python-mode-hook 'flycheck-mode)

;; You can also set it up globally with: (add-hook 'after-init-hook #'global-flycheck-mode).

;;----------------------------------------------------------------------------

(provide 'init-python)
