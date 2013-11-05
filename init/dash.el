;; -*- coding: utf-8 -*-

(when (featurep 'ns)
  (autoload 'dash-at-point "dash-at-point"
    "Search the word at point with Dash." t nil)
  (global-set-key "\C-cd" 'dash-at-point))

;; eof
