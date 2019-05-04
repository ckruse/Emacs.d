(use-package display-line-numbers
  :commands display-line-numbers
  :init
  (add-hook 'prog-mode-hook 'display-line-numbers-mode))

(use-package diminish
  :ensure t)

(use-package paradox
  :ensure t
  :commands paradox-list-packages paradox-upgrade-packages)

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

(require 'init-projectile)

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

(use-package expand-region
  :ensure t
  :commands expand-region)

(use-package multiple-cursors
  :ensure t
  :commands mc/edit-lines mc/mark-next-like-this mc/mark-previous-like-this mc/mark-all-like-this)


(use-package flycheck
  :ensure t
  :commands (global-flycheck-mode flycheck-add-next-checker)
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

(require 'init-company)


(use-package magit
  :ensure t
  :commands magit-status
  :config
  (add-to-list 'magit-no-confirm 'stage-all-changes)
  (add-to-list 'magit-no-confirm 'unstage-all-changes)
  (setq magit-save-repository-buffers nil
        magit-last-seen-setup-instructions "2.1.0")
  (push (cons [unpushed status] 'show) magit-section-initial-visibility-alist)
  (push (cons [stashes status] 'show) magit-section-initial-visibility-alist))

(use-package git-timemachine
  :ensure t
  :commands git-timemachine)


(use-package gist
  :ensure t
  :commands gist-region gist-region-private gist-buffer gist-buffer-private gist-region-or-buffer gist-region-or-buffer-private)

(use-package editorconfig
  :ensure t
  :diminish editorconfig-mode
  :hook ((prog-mode . editorconfig-mode)
         (text-mode . editorconfig-mode)))

(use-package highlight-indent-guides
  :ensure t
  :diminish
  :hook (prog-mode . (lambda ()
                       ;; WORKAROUND:Fix the issue of not displaying plots
                       ;; @see https://github.com/DarthFennec/highlight-indent-guides/issues/55
                       (unless (eq major-mode 'ein:notebook-multilang-mode)
                         (highlight-indent-guides-mode 1))))
  :config
  ;; (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive t
        highlight-indent-guides-delay 0.4
        highlight-indent-guides-auto-even-face-perc 2.5
        highlight-indent-guides-auto-odd-face-perc 5
        highlight-indent-guides-auto-top-even-face-perc 15
        highlight-indent-guides-auto-top-odd-face-perc 15))

(use-package dockerfile-mode
  :ensure t)

(use-package move-text
  :ensure t
  :commands move-text-up move-text-down
  :bind
  (([m-up] . move-text-up)
   ([m-down] . move-text-down)))

(provide 'packages)
