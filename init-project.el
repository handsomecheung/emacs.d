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

;------------------perspective------------------------------
(require-package 'perspective)
(persp-mode)

;; (defmacro custom-persp (name &rest body)
;;        `(let ((initialize (not (gethash ,name perspectives-hash)))
;;               (current-perspective persp-curr))
;;           (persp-switch ,name)
;;           (when initialize ,@body)
;;           (setq persp-last current-perspective)))

;; (defun custom-persp/org ()
;;   (interactive)
;;   (custom-persp "@org"
;;   (find-file (first org-agenda-files))))

;; (global-set-key (kbd "C-p o") 'custom-persp/org)

;------------------------------------------------------------------------------------------------------------


;; ------------------------------------------------------------------------------------------
;; get project root dir: fork from fiplr
;; ------------------------------------------------------------------------------------------
(defvar default-project-root-markers '(".git" ".svn" ".hg" ".bzr"))

(defun project-root ()
  "Get project root dir, other wise return nil"
  (let ((cwd (if (buffer-file-name)
                 (directory-file-name
                  (file-name-directory (buffer-file-name)))
               (file-truename "."))))
    (or (find-project-root cwd default-project-root-markers)
        cwd)))

(defun find-project-root (path root-markers)
  "Tail-recursive part of project root dir."
  (let* ((this-dir (file-name-as-directory (file-truename path)))
         (parent-dir (expand-file-name (concat this-dir "..")))
         (system-root-dir (expand-file-name "/")))
    (cond
     ((project-root-p path root-markers) this-dir)
     ((equal system-root-dir this-dir) nil)
     (t (find-project-root parent-dir root-markers)))))

(defun project-root-p (path root-markers)
  "Predicate to check if the given directory is a git root dir."
  (let ((dir (file-name-as-directory path)))
    (cl-member-if (lambda (marker)
                    (file-exists-p (concat dir marker)))
                  root-markers)))

(defun project-name ()
  "Get project name by project root"
  (let ((root (project-root)))
    (if root
        (replace-regexp-in-string
         "^.*/\\([^/]+\\)/$" "\\1"
         root))))

;; ------------------------------------------------------------------------------------------


(provide 'init-project)
