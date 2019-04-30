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

(use-package poly-markdown
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.md" . poly-markdown-mode)))

(use-package yaml-mode
  :ensure t
  :commands yaml-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;; (use-package po-mode
;;   :ensure t
;;   :commands po-mode
;;   :init (add-to-list 'auto-mode-alist '("\\.po\\'" . po-mode)))

(provide 'languages)
