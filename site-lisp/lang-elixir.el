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
  :hook (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "~/dev/emacs/elixir-ls/release")
  (add-hook 'elixir-mode-hook
            (lambda () (add-hook 'before-save-hook 'lsp-format-buffer nil t))))

(use-package flycheck-mix
  :ensure t
  :commands flycheck-mix-setup
  :init
  (defvar elixir-enable-compilation-checking nil)

  (add-to-list 'safe-local-variable-values
                   (cons 'elixir-enable-compilation-checking nil))
  (add-to-list 'safe-local-variable-values
               (cons 'elixir-enable-compilation-checking t))

  (add-hook 'hack-local-variables-hook
            (lambda ()
              (when (and (or elixir-enable-compilation-checking) (string-equal major-mode "elixir-mode"))
                (flycheck-mix-setup)
                ;; enable credo only if there are no compilation errors
                (flycheck-add-next-checker 'elixir-mix '(warning . elixir-credo)))))
  (add-hook 'flycheck-before-syntax-check-hook (lambda ()
                                                 (when (string-equal major-mode "elixir-mode")
                                                   (setenv "MIX_ENV" "test")))))



(use-package flycheck-credo
  :ensure t
  :commands flycheck-credo-setup 
  :after flycheck
  :init
  (eval-after-load 'flycheck
    '(flycheck-credo-setup)))

(provide 'lang-elixir)
