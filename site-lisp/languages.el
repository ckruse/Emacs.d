;; -*- coding: utf-8 -*-

(use-package markdown-mode
  :ensure t
  :commands markdown-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

(use-package php-mode
  :ensure t
  :commands php-mode
  :init
  (add-hook 'php-mode-hook '(lambda ()
                              (php-set-style "ck")))

  :config
  (c-add-style "ck" '("php"
                      (c-basic-offset . 2)
                      (c-offsets-alist . ((case-label . 0)))
                      (tab-width . 2))))

;;;;;;;;;;;;;;
;;;; ruby ;;;;
;;;;;;;;;;;;;;

(use-package ruby-mode
  :commands ruby-mode
  :init
  (add-hook 'ruby-mode-hook 'turn-on-font-lock)
  (add-hook 'ruby-mode-hook (lambda ()
                              (setq tab-width 2
                                    indent-tabs-mode nil
                                    ruby-insert-encoding-magic-comment nil)))

  (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.prawn$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.xlsx\\.axlsx$" . ruby-mode)))

(use-package rubocop
  :ensure t
  :commands rubocop-mode
  :after ruby-mode
  :diminish rubocop-mode
  :init
  (add-hook 'ruby-mode-hook #'rubocop-mode))

(use-package inf-ruby
  :ensure t
  :commands inf-ruby-mode
  :after ruby-mode
  :init
  (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
  (add-hook 'compilation-filter-hook 'inf-ruby-auto-enter))

(use-package robe
  :ensure t
  :commands robe-mode
  :after inf-ruby company
  :diminish (robe-mode . "Ⓡ")
  :init
  (add-hook 'ruby-mode-hook 'robe-mode)
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

(use-package rspec-mode
  :ensure t
  :diminish rspec-mode
  :commands rspec-mode
  :init (add-hook 'ruby-mode-hook #'rspec-mode)
  :config (rspec-install-snippets))


(use-package js2-mode
  :ensure t
  :commands js2-mode
  :init
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  :config
  (custom-set-variables
   '(js2-basic-offset 2)))


(use-package yaml-mode
  :ensure t
  :commands yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))


;;;;;;;;;;;;;;;;
;;;; elixir ;;;;
;;;;;;;;;;;;;;;;

(use-package erlang-start
  :mode (("\\.[eh]rl\\'" . erlang-mode)
         ("\\.yaws?\\'" . erlang-mode)
         ("\\.escript?\\'" . erlang-mode))
  :init
  ;; Find the erlang-root-dir automatically, either it is already set, or
  ;; elisp knows where it is, or `which' knows where.
  (let ((erootdir (if (boundp 'erlang-root-dir) erlang-root-dir nil))
        (exe-find (if (executable-find "erl")
                      (directory-file-name (file-name-directory (executable-find "erl")))
                    nil))
        (shell-cmd-find (if (file-name-directory (shell-command-to-string "which erl"))
                            (directory-file-name (file-name-directory (shell-command-to-string "which erl")))
                          nil)))


    (if (and (equal erootdir nil)
             (equal exe-find "")
             (equal shell-cmd-find ""))
        (error "Could not find erlang, set the variable `erlang-root-dir'"))

    (if (equal erootdir nil)
        (if (equal exe-find "")
            (setq erlang-root-dir shell-cmd-find)
          (setq erlang-root-dir exe-find))))
  :config
  ;; Set the manual directory and indent level

  (setq edts-man-root (expand-file-name ".." erlang-root-dir)
        erlang-indent-level 4)

  ;; Add Erlangs Emacs directory to the load-path

  (add-to-list 'load-path (file-expand-wildcards
                           (concat erlang-root-dir
                                   "../lib/tools-*/emacs"))))

(use-package elixir-mode
  :ensure t
  :commands elixir-mode
  :init
  (add-hook 'elixir-mode-hook
            (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))

  (add-hook 'elixir-format-hook (lambda ()
                                  (if (and (projectile-project-p)
                                           (file-exists-p (concat (locate-dominating-file buffer-file-name ".formatter.exs") ".formatter.exs")))
                                      (setq elixir-format-arguments
                                            (list "--dot-formatter"
                                                  (concat (locate-dominating-file buffer-file-name ".formatter.exs") ".formatter.exs")))
                                    (setq elixir-format-arguments nil)))))

(use-package alchemist
  :ensure t
  :commands alchemist-mode
  :after elixir-mode
  :diminish (alchemist-mode . "Ⓐ")
  :init
  (add-hook 'elixir-mode-hook 'alchemist-mode))

(use-package flycheck-credo
  :ensure t
  :commands flycheck-credo-setup 
  :after flycheck
  :init
  (eval-after-load 'flycheck
    '(flycheck-credo-setup)))

;; css mode config
(setq css-indent-offset 2)

(use-package po-mode
  :ensure t
  :commands po-mode
  :init (add-to-list 'auto-mode-alist '("\\.po\\'" . po-mode)))

(provide 'languages)
