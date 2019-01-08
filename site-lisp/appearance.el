(add-to-list 'default-frame-alist '(font . "Source Code Pro-11"))

(use-package spacemacs-theme
  :ensure t
  :defer
  :init
  (load-theme 'spacemacs-dark t))

(use-package leuven-theme
  :disabled
  :ensure t
  :init
  (load-theme 'leuven t)
  (custom-theme-set-faces
   'leuven
   '(org-level-1 nil :overline nil) ; I don't like the overline in L1 and L2
   '(org-level-2 nil :overline nil) ;  Headings, so I remove it
   '(org-block-begin-line nil :underline nil)
   '(org-block-end-line nil :overline nil)
   '(hl-line nil :underline nil)))

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
  ;;(setq sml/theme 'dark)
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
  ;;(setq sml/theme 'dark)
  (sml/setup))

(provide 'appearance)
