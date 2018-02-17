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

(provide 'j)
;;; j.el ends here
