(defun erl-get-lib-path (path)
  (format "%s/%s/emacs" path (car (directory-files path nil "^tools")))
  )

(cond
 ((file-exists-p "/usr/local/lib/erlang")
  (setq load-path (cons (erl-get-lib-path "/usr/local/lib/erlang/lib") load-path))
  (setq erlang-root-dir "/usr/local/lib/erlang")
(setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
  )

 ((file-exists-p "/usr/lib/erlang")
  (setq load-path (cons (erl-get-lib-path "/usr/lib/erlang/lib") load-path))
  (setq erlang-root-dir "/usr/lib/erlang")
  (setq exec-path (cons "/usr/lib/erlang/bin" exec-path))
  )
 )


(require 'erlang-start)

;; eof
