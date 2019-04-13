(use-package shell
  :hook (shell-mode . ansi-color-for-comint-mode-on))

(use-package company-shell
  :ensure t
  :after company
  :init (cl-pushnew '(company-shell company-shell-env company-fish-shell)
                    company-backends))

(use-package shell-pop
  :ensure t
  :init
  (setq shell-pop-shell-type
        '("ansi-term" "*ansi-term*"
          (lambda () (ansi-term shell-pop-term-shell)))))

(provide 'init-shell)
