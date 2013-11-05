(autoload 'scss-mode
          "scss-mode"
          "A mode for SCSS"
          t)

(add-to-list 'auto-mode-alist
             '("\\.scss\\'" . scss-mode)
             )

(setq-default scss-compile-at-save nil)
(setq-default css-indent-offset 2)

;; eof
