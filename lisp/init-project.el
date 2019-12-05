;;--------------------------------------------------------------------------------
;; fiplr
;; --------------------------------------------------------------------------------

;; (require-package 'fiplr)
;; (setq fiplr-root-markers '(".git" ".svn"))
;; (setq fiplr-ignored-globs '((directories (".git" ".svn" "spec"))
;;                             (files ("*.jpg" "*.png" "*.zip" "*~"))))
;; (global-set-key (kbd "C-x f") 'fiplr-find-file)
;; --------------------------------------------------------------------------------

;;--------------------------------------------------------------------------------
;; new function: find file in repo
;; http://puntoblogspot.blogspot.com/2013/10/yet-another-find-file-in-project-in.html
;; --------------------------------------------------------------------------------
(defun rgc-find-git-root ()
  "Find git root directory from current directory."
  (interactive)
  (rgc-member-directory default-directory
                        "~/"
                        (lambda (x)
                          (file-exists-p (concat x ".git")))))

(defun rgc-member-directory (from to fun &optional if-nil)
  "Returns a directory between `from' and `to' for wich `fun'
returns non nil. The search begins on the child 'from' and goes
up till 'to', or '/'. If `if-nil' is provided, in case of not
finding any suitable directory, it returns it instead of `to'"
  (when (not (file-exists-p from))
    (return))
  (if (or (equal (expand-file-name from) (expand-file-name to))
          (equal from "/")) ;how to do it multiplatform?
      (or if-nil to)
    (if (funcall fun from) from
      (rgc-member-directory (expand-file-name (concat from "/../")) ;how to do it multiplatform?
                            to
                            fun
                            if-nil))))

(defun find-file-in-repo ()
  (interactive)
  (let* ((git-root (rgc-find-git-root))
         (ido-enable-regexp nil)
         (repo-files (split-string
                      (with-temp-buffer
                        (cd git-root)
                        (shell-command "git ls-files" t)
                        (buffer-string)))))
    (find-file (concat git-root "/"
                       (ido-completing-read "file: " repo-files t t)))))
(global-set-key (kbd "C-x f") 'find-file-in-repo)

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

;; (let ((enable-recursive-minibuffers t))
;;   (find-file (expand-file-name (ido-completing-read "Project file:" '("spec/models/user_login_info_spec.rb" "spec/models/user_new_spec.rb") nil t) "/Users/handsomecheung/Dropbox/workspace/tap4fun/project_t4f/kings-server/")))


;------------------project-buffer-mode------------------------------
(require 'project-buffer-mode)
;------------------------------------------------------------------------------------------------------------

;------------------perspective------------------------------
(require-package 'perspective)
(persp-mode)

(custom-set-variables '(persp-state-default-file "~/.emacs.d/persp-state"))

(defun persp-auto-save ()
  "Call persp-state-save non-interactive."
  (interactive)
  (persp-state-save persp-state-default-file))

(defun persp-auto-load ()
  "Call persp-state-load non-interactive."
  (interactive)
  (persp-state-load persp-state-default-file))

;; (add-hook 'kill-emacs-hook #'persp-state-save)
;; ------------------------------------------------------------------------------------------


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
        nil)))

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
