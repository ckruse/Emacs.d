(add-to-list 'default-frame-alist '(font . "Source Code Pro-11"))

(use-package spacemacs-theme
  :disabled
  :ensure t
  :defer
  :init
  (load-theme 'spacemacs-dark t))

(use-package monokai-theme
  :ensure t
  :defer
  :init
  (load-theme 'monokai t))

;; (use-package spaceline-config
;;   :ensure spaceline
;;   :config
;;   ;(when (ck/is-osx)
;;   ;  (setq powerline-image-apple-rgb t))

;;   ;(setq-default powerline-default-separator 'utf-8)
;;   (setq-default powerline-default-separator 'wave)

;;   ;(spaceline-toggle-input-method-off)
;;   (spaceline-toggle-which-function-on)
;;   (spaceline-toggle-hud-off)
;;   ;(spaceline-toggle-buffer-position-off)

;;   (spaceline-helm-mode 1)
;;   (spaceline-emacs-theme))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'respectful)
  (setq sml/no-confirm-load-theme t)

  (add-to-list 'sml/replacer-regexp-list
               '("^~/dev/\\(\\w+\\)/"
                 (lambda (s) (concat (match-string 1 s) ": ")))
               t)

  (add-to-list 'sml/replacer-regexp-list
               '("^~/sites/\\(\\w+\\)/"
                 (lambda (s) (concat (match-string 1 s) ": ")))
               t)
  :init
  (sml/setup))

(provide 'appearance)
