;; -*- coding: utf-8 -*-

(require 'smart-mode-line)

(custom-set-variables
 '(sml/hidden-modes (quote (" hl-p" " my-keys" " pair" " HRB" " AC" " GitGutter" " Flymake" " yas" " SP" " WS" " MRev")))
 ;'(sml/override-theme nil)
 )

(add-to-list 'sml/replacer-regexp-list '("^~/\\(data/\\)?[Ss]ites/" ":WEB:"))
(add-to-list 'sml/replacer-regexp-list '("^~/\\(data/\\)?dev/" ":DEV:"))
(add-to-list 'sml/replacer-regexp-list '("^~/\\(data/\\)?dev/postgres/" ":PG:"))
(add-to-list 'sml/replacer-regexp-list '("^~/\\(data/\\)?Documents/" ":DOC:"))

(if after-init-time (sml/setup)
  (add-hook 'after-init-hook 'sml/setup))

;; eof
