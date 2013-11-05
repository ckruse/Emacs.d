;; -*- coding: utf-8 -*-

(add-to-list 'load-path "~/.emacs.d/packages/smart-mode-line/")

(require 'smart-mode-line)

(custom-set-variables
 '(sml/hidden-modes (quote (" hl-p" " my-keys" " pair" " HRB" " AC" " GitGutter" " Flymake")))
 '(sml/override-theme nil)
 )

(add-to-list 'sml/replacer-regexp-list '("^~/[Ss]ites/" ":WEB:"))
(add-to-list 'sml/replacer-regexp-list '("^~/dev/" ":DEV:"))

(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

;; eof
