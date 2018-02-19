;; Some code for J (APL)

;;; Code:

;; http://www.jsoftware.com/help/dictionary/vocabul.htm

(defvar j-console-bin "~/jbld/j64/bin/jconsole"
  "The location of the jconsole binary.

Set to a default GNU/Linux build directory, as jvm also installs
a jconsole in PATH.")

(defun j-repl ()
  "Launch a J repl."
  (interactive)
  ;; (comint-run j-console-bin)
  (switch-to-buffer (make-comint "jconsole" j-console-bin))
  )

(defconst j-mode-font-lock-keywords-1
  (list
   '("\\([[:lower:]]+?\\)=" 1 font-lock-function-name-face)
   '("=[:.]" . font-lock-keyword-face)
   '("NB\\..*" . font-lock-comment-face)
   '("[[:upper:]][[:lower:]]*" . font-lock-variable-name-face)
   ))

;;;###autoload
(define-derived-mode j-mode text-mode "J" ()
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
