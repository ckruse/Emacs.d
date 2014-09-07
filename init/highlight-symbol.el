;; -*- coding: utf-8 -*-

(require 'highlight-symbol)

(highlight-symbol-nav-mode)
(add-hook 'prog-mode-hook (lambda () (highlight-symbol-mode)))
(add-hook 'org-mode-hook (lambda () (highlight-symbol-mode)))

(setq highlight-symbol-on-navigation-p t)
(setq highlight-symbol-idle-delay 0.8)


;; eof
