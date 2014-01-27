(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")

(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-hook 'ruby-mode-hook (lambda ()
                            (setq tab-width 2
                                  indent-tabs-mode nil
                                  ruby-deep-arglist nil
                                  ruby-deep-indent-paren nil
                                  ruby-insert-encoding-magic-comment nil
                                  )
                            )
          )

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.prawn$" . ruby-mode))

;; eof
