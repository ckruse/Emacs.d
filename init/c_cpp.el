(defun ck-init-c ()
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro 2)
  (c-set-offset 'case-label 2)
  (c-set-offset 'arglist-close 0)
)

(add-hook 'c-mode-hook 'ck-init-c)
(add-hook 'c++-mode-hook 'ck-init-c)

(setq c-basic-offset 2)
(setq-default c-basic-offset 2)

;; eof
