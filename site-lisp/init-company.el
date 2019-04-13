(use-package company
  :ensure t
  :defines (company-dabbrev-ignore-case company-dabbrev-downcase)
  :commands company-abort
  :hook (after-init . global-company-mode)
  :bind (("M-/" . company-complete)
         ("<backtab>" . company-yasnippet)
         :map company-active-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next)
         ("<tab>" . company-complete-common-or-cycle)
         ("<backtab>" . my-company-yasnippet)
         ;; ("C-c C-y" . my-company-yasnippet)
         :map company-search-map
         ("C-p" . company-select-previous)
         ("C-n" . company-select-next))

  :init
  (defun my-company-yasnippet ()
    (interactive)
    (company-abort)
    (call-interactively 'company-yasnippet))

  :config
  (setq company-tooltip-limit 15
        company-tooltip-align-annotations t
        company-echo-delay 0
        company-idle-delay .2
        company-tooltip-idle-delay 1
        company-minimum-prefix-length 2
        company-begin-commands '(self-insert-command)
        company-frontends '(company-pseudo-tooltip-unless-just-one-frontend-with-delay company-preview-frontend company-echo-metadata-frontend)
        ;company-require-match 'never
        company-require-match nil
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-auto-complete-chars nil)

  ;; (define-key company-active-map (kbd "<return>") nil)
  ;; (define-key company-active-map (kbd "RET") nil)

  (dolist (key '("<return>" "RET"))
    ;; Here we are using an advanced feature of define-key that lets
    ;; us pass an "extended menu item" instead of an interactive
    ;; function. Doing this allows RET to regain its usual
    ;; functionality when the user has not explicitly interacted with
    ;; Company.
    (define-key company-active-map (kbd key)
      `(menu-item nil company-complete
                  :filter ,(lambda (cmd)
                             (when (company-explicit-action-p)
                               cmd)))))
  (define-key company-active-map (kbd "TAB") #'company-complete-selection)
  (define-key company-active-map (kbd "SPC") nil))

(defun ck/init-web-mode ()
  (lambda ()
    (push '(company-web-html company-css) company-backends)
    (set (make-local-variable 'company-minimum-prefix-length) 0)))

(use-package company-web-html
  :ensure company-web
  :commands company-web-html
  :after (company-mode web-mode)
  :hook (web-mode ck/init-web-mode))

(use-package company-ansible
  :ensure t
  :commands company-ansible
  :after company-mode
  :init
  (add-to-list 'company-backends 'company-ansible))


(provide 'init-company)
