(with-eval-after-load 'magit
  (diminish 'magit-auto-revert-mode)
  (diminish 'auto-revert-mode))

(add-hook 'after-init-hook '(lambda ()
                              (diminish 'company-mode "Ⓒ")
                              (diminish 'eldoc-mode)))

(provide 'hide-minors)
