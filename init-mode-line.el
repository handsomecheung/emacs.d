;;; mode line: fork from molokai-theme-kit.el

;; Copyright (C) 2013 Huang Bin

;; Author: Huang Bin <embrace.hbin@gmail.com>
;; URL: https://github.com/hbin/molokai-theme
;; Version: 0.8

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This is optional UI settings for molokai theme.
;;
;; Include: limun style, mode line...

;;; Requirements:
;;
;; Emacs 24

;;; Code:

;;
;; linum style
;;
(require 'linum)
(require 'init-git)
(require 'init-project)
(require-package 'window-number)
(setq linum-format "%4d ")

(toggle-indicate-empty-lines nil)

;;
;; mode-line
;;
;; http://emacs-fu.blogspot.com/2011/08/customizing-mode-line.html

(require-package 'evil)
(defun emacs-or-vim? ()
  "emacs mode or vim mode."
  (if (evil-emacs-state-p) "Emacs" "Vim"))

(defun show-vim-state ()
  "show vim(evil) state: normal, insert, replace, and visual type."
  (cond ((evil-normal-state-p) "Normal")
        ((evil-insert-state-p) "Insert")
        ((evil-replace-state-p) "Replace")
        ((evil-visual-state-p)
         (let ((visual-type (evil-visual-type)))
           (cond ((string= visual-type "line") "Visual Line")
                 ((string= visual-type "inclusive") "Visual")
                 ((string= visual-type "block") "Visual Block"))))))

(defun show-emacs-state ()
  "show emacs state: Ovr or Ins"
  (if overwrite-mode "Ovr" "Ins"))

(defun show-edit-state ()
  (if (evil-emacs-state-p) (show-emacs-state) (show-vim-state)))

(setq-default mode-line-format
              (list
               "[" '(:eval (propertize (emacs-or-vim?)
                                   'face 'font-lock-preprocessor-face
                                   'help-echo "emacs or vim state")) "]"
               "[" '(:eval (propertize (show-edit-state)
                                   'face 'font-lock-preprocessor-face
                                   'help-echo "edit state")) "]"

               ;; was this buffer modified since the last save?
               ;; is this buffer read-only?
               '(:eval (if buffer-read-only
                         (concat "["  (propertize "RO"
                                                  'face 'font-lock-type-face
                                                  'help-echo "Buffer is read-only") "]")

                         (if (buffer-modified-p) (concat "[" (propertize "Mod"
                                                         'face 'font-lock-warning-face
                                                         'help-echo "Buffer has been modified") "]"))))

               ;; the buffer name; the file name as a tool tip
               '(:eval (propertize " %b " 'face 'font-lock-keyword-face 'help-echo (buffer-file-name)))

               ;; line and column
               "(" (propertize "%l" 'face 'font-lock-type-face) "," (propertize "%c" 'face 'font-lock-type-face) ") "

               ;; relative position, size of file
               "[" (propertize "%p" 'face 'font-lock-constant-face) "/" (propertize "%I" 'face 'font-lock-constant-face) "] "

               ;; show current function name
               '(:eval (when which-func-mode
                         (concat "[" (propertize (which-function) 'face 'font-lock-keyword-face) "] ")))


               ;; show git branch
               '(:eval (when (git-branch-name)
                         (concat "[Git: " (propertize (git-branch-name) 'face 'font-lock-preprocessor-face) "] ")))

               ;; show project name
               '(:eval (when (project-name)
                         (concat "[" (propertize (project-name) 'face 'font-lock-preprocessor-face) "] ")))

               ;; the current major mode for the buffer.
               "[" '(:eval (propertize "%m" 'face 'font-lock-string-face 'help-echo buffer-file-coding-system)) "] "

               ;; show window number in mode line
               "-" '(:eval (propertize (number-to-string (window-number)) 'face 'font-lock-warning-face)) "- "

               ;; add the time, with the date and the emacs uptime in the tooltip
               '(:eval (propertize (format-time-string "%H:%M")
                                   'help-echo
                                   (concat (format-time-string "%c; ")
                                           (emacs-uptime "Uptime:%hh"))))
               " --"
               ;; i don't want to see minor-modes; but if you want, uncomment this:
               ;; minor-mode-alist  ;; list of minor modes
               "%-" ;; fill with '-'
               ))

(provide 'init-mode-line)
