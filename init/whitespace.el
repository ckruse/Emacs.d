;; -*- coding: utf-8 -*-

(require 'whitespace)
(global-whitespace-mode t)

(setq show-trailing-whitespace t)
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(setq whitespace-line-column 79)
(setq whitespace-style
      '(face lines-tail trailing indentation))

;;  indentation::tab indentation::space tabs tab-mark spaces space-mark

(custom-set-faces
 '(whitespace-trailing ((t (:background "#f2777a" :weight bold)))))
;; eof
