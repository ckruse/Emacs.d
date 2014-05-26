;; -*- coding: utf-8 -*-

(require 'helm-dash)

(setq helm-dash-docsets '("Bash" "Emacs_Lisp" "PostgreSQL"
                          "HTML" "JavaScript" "CSS" "C"
                          "C++" "PHP" "Ruby" "Ruby_on_Rails_3"
                          "Ruby_on_Rails_4" "jQuery"))

(global-set-key [f1] 'helm-dash-at-point)

;; eof
