;; -*- coding: utf-8 -*-

(electric-indent-mode t)

(add-hook 'yaml-mode-hook (lambda ()
                            (electric-indent-local-mode -1)))

; eof
