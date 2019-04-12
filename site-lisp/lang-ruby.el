(use-package ruby-mode
  :commands ruby-mode
  :init
  (add-hook 'ruby-mode-hook 'turn-on-font-lock)
  (add-hook 'ruby-mode-hook (lambda ()
                              (setq tab-width 2
                                    indent-tabs-mode nil
                                    ruby-insert-encoding-magic-comment nil)))
  (add-hook 'ruby-mode-hook #'lsp)

  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.prawn$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.xlsx\\.axlsx$" . ruby-mode)))

(use-package inf-ruby
  :ensure t
  :commands inf-ruby-mode
  :after ruby-mode
  :init
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

(use-package rubocop
  :ensure t
  :commands rubocop-mode
  :after ruby-mode
  :diminish rubocop-mode
  :init
  (add-hook 'ruby-mode-hook #'rubocop-mode))

(use-package rspec-mode
  :ensure t
  :diminish rspec-mode
  :commands rspec-mode
  :init (add-hook 'ruby-mode-hook #'rspec-mode)
  :config (rspec-install-snippets))

(provide 'lang-ruby)
