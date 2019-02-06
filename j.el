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
    (char ?- ?= ?< ?> ?. ?: ?+ ?* ?- ?% ?^ ?$ ?# ?! "~" ";" ?@ ?&))
   " "))

(defconst j-mode-font-lock-keywords-1
  (list
   '("NB\\..*" . font-lock-comment-face)
   `(,j-mode-verb-regex . font-lock-builtin-face)
   '("^\\([a-zA-Z0-9]+?\\)=" 1 font-lock-function-name-face)
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
