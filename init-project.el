;;--------------------------------------------------------------------------------
;; fiplr
;; --------------------------------------------------------------------------------

(require-package 'fiplr)

(setq fiplr-root-markers '(".git" ".svn"))
(setq fiplr-ignored-globs '((directories (".git" ".svn"))
                            (files ("*.jpg" "*.png" "*.zip" "*~"))))

(global-set-key (kbd "C-x f") 'fiplr-find-file)
;; --------------------------------------------------------------------------------

(defvar af-ido-flex-fuzzy-limit (* 2000 5))
(defadvice ido-set-matches-1 (around my-ido-set-matches-1 activate)
  (let ((ido-enable-flex-matching (< (* (length (ad-get-arg 0)) (length ido-text))
                                     af-ido-flex-fuzzy-limit)))
    ad-do-it))
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t)) (visit-tags-table-buffer))
    (find-file (expand-file-name
                (ido-completing-read "Project file: "
                                     (tags-table-files) nil t)))))

(global-set-key (kbd "C-,") 'ido-find-file-in-tag-files)


;------------------project-buffer-mode------------------------------
(require 'project-buffer-mode)
;------------------------------------------------------------------------------------------------------------


(provide 'init-project)
