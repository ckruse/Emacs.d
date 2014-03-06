;; -*- coding: utf-8 -*-

(require 'flymake-ruby)
(when (featurep 'ns)
  (setq flymake-ruby-executable "/usr/local/bin/ruby"))
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)

  ;; (progn
(require 'flymake-jshint)
(setq jshint-configuration-path "~/.emacs.d/jshint.json")
(add-hook 'js-mode-hook 'flymake-jshint-load)
(add-hook 'php-mode-hook 'flymake-mode)


(require 'flymake-cursor)

;; eof
