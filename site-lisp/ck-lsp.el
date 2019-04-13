(use-package lsp-mode
  :ensure t
  :diminish lsp-mode
  :commands lsp
  :hook (css-mode . lsp)
  :bind (:map lsp-mode-map
              ("C-c C-d" . lsp-describe-thing-at-point))
  :init
  (setq lsp-prefer-flymake nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-auto-guess-root t))

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :config
;;   (setq lsp-ui-doc-enable nil)
;;   (setq lsp-ui-peek-enable nil))

(use-package company-lsp
  :ensure t
  :commands company-lsp
  :init
  (setq company-lsp-cache-candidates 'auto))

(provide 'ck-lsp)
