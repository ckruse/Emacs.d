(defun ck/web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-code-indent-offset 2
          web-mode-enable-auto-indentation nil))

(use-package web-mode
  :ensure t
  :commands web-mode
  :hook (web-mode . lsp)
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

(use-package css-mode
  :init (setq css-indent-offset 2))

(use-package php-mode
  :ensure t
  :commands php-mode
  :hook (php-mode . lsp)
  :init
  (add-hook 'php-mode-hook '(lambda ()
                              (php-set-style "ck")))

  :config
  (c-add-style "ck" '("php"
                      (c-basic-offset . 2)
                      (c-offsets-alist . ((case-label . 0)))
                      (tab-width . 2))))


(provide 'init-web)
