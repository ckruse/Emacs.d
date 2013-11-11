;; -*- coding: utf-8 -*-

(require 'flymake-ruby)
(when (featurep 'ns)
  (setq flymake-ruby-executable "/usr/local/bin/ruby"))
(add-hook 'ruby-mode-hook 'flymake-ruby-load)

(require 'flymake-sass)
(add-hook 'sass-mode-hook 'flymake-sass-load)

;; (if (featurep 'ns)
;;     (progn
;;       (setq load-path  (cons (expand-file-name "~/.emacs.d/packages/flymake-jslint/") load-path))
;;       (require 'flymake-jslint)
;;       (setq flymake-jslint-args "")
;;       (setq flymake-jslint-command "/usr/local/bin/jsl")
;;       (add-hook 'js-mode-hook 'flymake-jslint-load))

  ;; (progn
(require 'flymake-jshint)
(setq jshint-configuration-path "~/.emacs.d/jshint.json")
(add-hook 'js-mode-hook 'flymake-jshint-load)
(add-hook 'php-mode-hook 'flymake-mode)


;; (setq load-path  (cons (expand-file-name "~/.emacs.d/packages/flymake-jslint/") load-path))
;; (require 'flymake-jslint)

;; (if (featurep 'ns)
;;     (progn
;;       (setq flymake-jslint-args "")
;;       (setq flymake-jslint-command "/usr/local/bin/jsl"))
;;   (progn
;;     (setq flymake-jslint-args "")
;;     (setq flymake-jslint-command "/usr/bin/jshint")))

;; (add-hook 'js-mode-hook 'flymake-jslint-load)

(require 'flymake-cursor)

;; eof
