(use-package display-line-numbers
  :commands display-line-numbers
  :init
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(use-package diminish
  :ensure t)

(use-package auto-package-update
  :ensure t
  :commands auto-package-update-now)

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :init
  (setq which-key-separator " "
        which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

(use-package smartparens-config
  :ensure smartparens
  :defer 0
  :diminish smartparens-mode
  :config
  (smartparens-global-mode)
  (show-smartparens-global-mode t))

(use-package helm-config
  :ensure helm
  :diminish helm-mode
  :defer 0
  :init
  (setq helm-M-x-fuzzy-match t
        helm-mode-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match t
        helm-locate-fuzzy-match t
        helm-semantic-fuzzy-match t
        helm-imenu-fuzzy-match t
        helm-completion-in-region-fuzzy-match t

        ;helm-autoresize-max-height 30
        ;helm-autoresize-min-height 30

        helm-split-window-in-side-p t
        helm-move-to-line-cycle-in-source t
        helm-ff-search-library-in-sexp t
        helm-scroll-amount 8)

  :config
  (helm-mode 1)
  (helm-autoresize-mode t))

(use-package uniquify
  :defer 0
  :config
  (setq uniquify-buffer-name-style 'post-forward uniquify-separator ":"))

(use-package mwim
  :ensure t
  :commands mwim-beginning-of-code-or-line mwim-end-of-code-or-line
  :bind (([home] . mwim-beginning-of-code-or-line)
         ([s-left] . mwim-beginning-of-code-or-line)
         ([end] . mwim-end-of-code-or-line)
         ([s-right] . mwim-end-of-code-or-line)))

(use-package tramp
  :defer t
  :init (setq tramp-use-ssh-controlmaster-options nil
              tramp-ssh-controlmaster-options nil))

(use-package projectile
  :ensure t
  :defer 0
  :diminish (projectile-mode . "Ⓟ")
  :init

  ;(defadvice projectile-project-root (around ignore-remote first activate)
  ;  (unless (file-remote-p default-directory) ad-do-it))

  ;(setq projectile-indexing-method 'find
  ;      projectile-enable-caching t
  ;      projectile-create-missing-test-files t))
  (setq projectile-keymap-prefix (kbd "C-c p")
        projectile-require-project-root nil)
  :config
  (projectile-global-mode 1))

(use-package helm-projectile
  :ensure t
  :after helm projectile
  :init
  (setq projectile-completion-system 'helm)
  :config
  (helm-projectile-on))

(use-package hydra
  :ensure t)

(use-package ace-window
  :ensure t
  :commands ace-window)

(use-package yasnippet
  :ensure t
  :defer 0
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1))

(use-package web-mode
  :ensure t
  :commands web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html\\.eex\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.atom\\.eex\\'" . web-mode))

  :config
  (add-hook 'web-mode-hook 'ck/web-mode-hook)

  (custom-set-variables
   '(web-mode-disable-auto-pairing t)
   '(web-mode-enable-auto-pairing nil)))

(use-package expand-region
  :ensure t
  :commands expand-region)

(use-package multiple-cursors
  :ensure t
  :commands mc/edit-lines mc/mark-next-like-this mc/mark-previous-like-this mc/mark-all-like-this)


(use-package flycheck
  :ensure t
  :commands global-flycheck-mode
  :diminish flycheck-mode
  :init (add-hook 'after-init-hook #'global-flycheck-mode)
  :config
  (setq flycheck-check-syntax-automatically '(mode-enabled new-line save)
        flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc javascript-jshint))
  (setq-default flycheck-disabled-checkers '(emacs-lisp emacs-lisp-checkdoc javascript-jshint))

  (add-hook 'flycheck-mode-hook #'(lambda ()
                                    (let* ((root (locate-dominating-file
                                                  (or (buffer-file-name) default-directory) "node_modules"))
                                           (eslint (and root
                                                        (expand-file-name "node_modules/eslint/bin/eslint.js" root))))

                                      (when (and eslint (file-executable-p eslint))
                                        (setq-local flycheck-javascript-eslint-executable eslint))))))



(use-package company-mode
  :ensure company
  :defer 0
  :init
  (setq company-tooltip-limit 20
        company-tooltip-align-annotations 't
        company-idle-delay .2
        company-minimum-prefix-length 2
        company-begin-commands '(self-insert-command))
  (global-company-mode))

(use-package company-web-html
  :ensure company-web
  :commands company-web-html
  :after company-mode web-mode
  :init
  (add-hook 'web-mode-hook (lambda ()
                             (push '(company-web-html company-css) company-backends)
                             (set (make-local-variable 'company-minimum-prefix-length) 0))))

(use-package company-ansible
  :ensure t
  :commands company-ansible
  :after company-mode
  :init
  (add-to-list 'company-backends 'company-ansible))



(use-package ibuffer
  :commands ibuffer
  :config
  (setq ibuffer-saved-filter-groups
        (list
         (cons "default"
               (append
                (ck/define-projectile-filter-groups)
                '(("dired" (mode . dired-mode))
                  ("Org" (or
                          (mode . org-mode)))
                  ("emacs" (or
                            (name . "^\\*scratch\\*$")
                            (name . "^\\*Messages\\*$")
                            (name . "^\\*Help\\*$")
                            (name . "^\\*Flycheck error messages\\*$"))))))))

  (add-hook 'ibuffer-mode-hook
            (lambda ()
              (ibuffer-switch-to-saved-filter-groups "default")))
  (setq ibuffer-show-empty-filter-groups nil))


(use-package magit
  :ensure t
  :commands magit-status
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (add-to-list 'magit-no-confirm 'unstage-all-changes)
  (setq magit-save-repository-buffers nil
        magit-last-seen-setup-instructions "2.1.0"))

(use-package magit-todos
  :after magit
  :ensure t
  :defer 0
  :init
  (setq magit-todos-require-colon nil)
  :config
  (magit-todos-mode))

(use-package git-timemachine
  :ensure t
  :commands git-timemachine)

(use-package projectile-rails
  :ensure t
  :after projectile
  :defer 0
  :diminish projectile-rails-mode
  :config
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c c r") 'hydra-projectile-rails/body))


(use-package gist
  :ensure t
  :commands gist-region gist-region-private gist-buffer gist-buffer-private gist-region-or-buffer gist-region-or-buffer-private)

(use-package js2-mode
  :ensure t
  :commands js2-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))

(use-package prettier-js
  :ensure t
  :commands prettier-js-mode prettier-js
  :diminish (prettier-js-mode . "⚚")
  :init
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'css-mode-hook 'prettier-js-mode)
  (add-hook 'scss-mode-hook 'prettier-js-mode)
  :config
  (setq prettier-js-command "prettier-eslint"))

(provide 'packages)
