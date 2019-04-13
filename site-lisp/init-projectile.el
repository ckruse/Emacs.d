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
  :after (helm projectile)
  :init
  (setq projectile-completion-system 'helm)
  :config
  (helm-projectile-on))

(use-package projectile-ripgrep
  :ensure t
  :commands projectile-ripgrep)


(use-package projectile-rails
  :ensure t
  :after projectile
  :defer 0
  :diminish projectile-rails-mode
  :config
  (projectile-rails-global-mode)
  (define-key projectile-rails-mode-map (kbd "C-c c r") 'hydra-projectile-rails/body))


(provide 'init-projectile)
