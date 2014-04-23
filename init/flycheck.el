;; -*- coding: utf-8 -*-

(add-hook 'after-init-hook #'global-flycheck-mode)

(setq flycheck-check-syntax-automatically '(mode-enabled new-line save))
(setq flycheck-jshintrc "~/.emacs.d/jshint.json")

; eof
