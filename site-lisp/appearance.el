(add-to-list 'default-frame-alist '(font . "Source Code Pro-11"))

(use-package spacemacs-theme
  :ensure t
  :defer
  :init
  (load-theme 'spacemacs-dark t))

(use-package spaceline-config
  :ensure spaceline
  :config
  ;(when (ck/is-osx)
  ;  (setq powerline-image-apple-rgb t))

  ;(setq-default powerline-default-separator 'utf-8)
  (setq-default powerline-default-separator 'wave)

  ;(spaceline-toggle-input-method-off)
  (spaceline-toggle-which-function-on)
  (spaceline-toggle-hud-off)
  ;(spaceline-toggle-buffer-position-off)

  (spaceline-helm-mode 1)
  (spaceline-emacs-theme))

(provide 'appearance)
