;;; j-mode.el --- Major mode for editing J (APL like)  files.  -*- lexical-binding: t -*-

;; Copyright (C) 2018, 2019 Matthew Carter <m@ahungry.com>

;; Author: Matthew Carter <m@ahungry.com>
;; Maintainer: Matthew Carter <m@ahungry.com>
;; URL: https://github.com/ahungry/j-mode
;; Version: 0.0.1
;; Date: 2019-02-06
;; Keywords: languages, j,
;; Package-Requires: ((emacs "25.1") (cl-lib "0.6.1"))

;; This file is NOT part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; Some code for J (APL)

;;; Code:

;; http://www.jsoftware.com/help/dictionary/vocabul.htm

(defvar j-console-bin "~/jbld/j64/bin/jconsole"
  "The location of the jconsole binary.

Set to a default GNU/Linux build directory, as jvm also installs
a jconsole in PATH.")

;;;###autoload
(defun j-repl ()
  "Launch a J repl."
  (interactive)
  ;; (comint-run j-console-bin)
  (switch-to-buffer (make-comint "jconsole" j-console-bin)))

(defconst j-mode-verb-regex
  (rx
   " "
   (one-or-more
    (char ?- ?< ?> ?. ?: ?+ ?* ?- ?% ?^ ?$ ?# ?! "~" ";" ?@ ?& "{" "," "["))
   " "))

(defconst j-mode-font-lock-keywords-1
  (list
   '("NB\\..*" . font-lock-comment-face)
   '("\\(\".*?\"\\)" . font-lock-string-face)
   '("\\('.*?'\\)" . font-lock-string-face)
   `(,j-mode-verb-regex . font-lock-builtin-face)
   '("\\(i\\.\\|a\\.\\)" . font-lock-builtin-face)
   '("\\(exit\\|coinsert\\|monad\\|define\\|smoutput\\|while.\\|end.\\|do.\\)" . font-lock-builtin-face)
   '("\\([a-z][a-zA-Z0-9]*\\)[ ]*=[:.]*" 1 font-lock-function-name-face)
   '("=[:.]*" . font-lock-keyword-face)
   '("[[:upper:]][[:lower:]]*" . font-lock-variable-name-face)
   ))

;;;###autoload
(define-derived-mode j-mode fundamental-mode "J" ()
  "Major mode for editing J files."
  :group 'languages
  (set (make-local-variable 'font-lock-defaults)
       '(j-mode-font-lock-keywords-1)))

;;;###autoload
(defun j-config ()
  "Default pickle setup and bindings."
  (interactive)
  (add-to-list 'auto-mode-alist '("\\.ijs\\'" . j-mode)))

(provide 'j)
;;; j.el ends here
