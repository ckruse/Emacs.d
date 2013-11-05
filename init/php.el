(defun ck-init-php ()
  (setq c-basic-offset 4)
  (c-set-offset 'arglist-cont 0)
  (c-set-offset 'arglist-intro 4)
  (c-set-offset 'case-label 4)
  (c-set-offset 'arglist-close 0)
)
(autoload 'php-mode
          "php-mode"
          "PHP mode"
          t)

(add-hook 'php-mode-hook 'ck-init-php)

;; eof
