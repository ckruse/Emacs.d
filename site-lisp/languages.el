;; -*- coding: utf-8 -*-

(require 'ck-lsp)

(require 'lang-ruby)
(require 'lang-js)
(require 'lang-elixir)


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

(use-package yaml-mode
  :ensure t
  :commands yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; css mode config
(setq css-indent-offset 2)

;; (use-package po-mode
;;   :ensure t
;;   :commands po-mode
;;   :init (add-to-list 'auto-mode-alist '("\\.po\\'" . po-mode)))

(provide 'languages)
