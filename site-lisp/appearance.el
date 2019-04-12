(setq ck/font '(font . "Source Code Pro-11"))
(when (file-exists-p "~/.emacs.d/machine.el")
  (load "~/.emacs.d/machine.el"))

(add-to-list 'default-frame-alist ck/font)

(use-package spacemacs-theme
  :disabled
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

(use-package smart-mode-line
  :disabled
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



(when (ck/is-osx)
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))

  (add-hook 'after-load-theme-hook
            (lambda ()
              (let ((bg (frame-parameter nil 'background-mode)))
                (set-frame-parameter nil 'ns-appearance bg)
                (setcdr (assq 'ns-appearance default-frame-alist) bg)))))

(defvar after-load-theme-hook nil
  "Hook run after a color theme is loaded using `load-theme'.")
(defun run-after-load-theme-hook (&rest _)
  "Run `after-load-theme-hook'."
  (run-hooks 'after-load-theme-hook))

(advice-add #'load-theme :after #'run-after-load-theme-hook)

(use-package doom-themes
  :ensure t
  :init
  (load-theme 'doom-one t)
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))


(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :init
  (setq doom-modeline-major-mode-color-icon t)
  (setq doom-modeline-github t))

(use-package all-the-icons
  :if (display-graphic-p)
  :custom-face
  ;; Reset colors since they are too dark in `doom-themes'
  (all-the-icons-silver ((((background dark)) :foreground "#716E68")
                         (((background light)) :foreground "#716E68")))
  (all-the-icons-lsilver ((((background dark)) :foreground "#B9B6AA")
                          (((background light)) :foreground "#7F7869")))
  (all-the-icons-dsilver ((((background dark)) :foreground "#838484")
                          (((background light)) :foreground "#838484")))
  :init
  (unless (member "all-the-icons" (font-family-list))
    (all-the-icons-install-fonts t))

  :config
  (add-to-list 'all-the-icons-icon-alist
               '("\\.ipynb" all-the-icons-fileicon "jupyter" :height 1.2 :face all-the-icons-orange))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(ein:notebooklist-mode all-the-icons-faicon "book" :face all-the-icons-orange))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(ein:notebook-mode all-the-icons-fileicon "jupyter" :height 1.2 :face all-the-icons-orange))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(ein:notebook-multilang-mode all-the-icons-fileicon "jupyter" :height 1.2 :face all-the-icons-orange))
  (add-to-list 'all-the-icons-icon-alist
               '("\\.epub$" all-the-icons-faicon "book" :face all-the-icons-green))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(nov-mode all-the-icons-faicon "book" :face all-the-icons-green))
  (add-to-list 'all-the-icons-mode-icon-alist
               '(gfm-mode all-the-icons-octicon "markdown" :face all-the-icons-blue)))

(provide 'appearance)
