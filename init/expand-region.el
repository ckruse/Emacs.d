;; -*- coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/packages/expand-region.el/")

(require 'expand-region)
(global-set-key (kbd "C-ö") 'er/expand-region)

;; eof
