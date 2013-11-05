;; -*- coding: utf-8 -*-

;; (add-to-list 'load-path "~/.emacs.d/packages/autopair/")
;; (require 'autopair)

;; (setq autopair-autowrap t)

;; (autopair-global-mode)

(add-to-list 'load-path "~/.emacs.d/packages/smartparens/")
(require 'smartparens-config)
(require 'smartparens-ruby)
(smartparens-global-mode)
(show-smartparens-global-mode t)


;; eof
