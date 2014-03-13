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

(setq flymake-log-level 2)
(setq flymake-gui-warnings-enabled nil)

(defun goto-next-problem()
  (interactive)
  (if (member 'flymake-mode minor-mode-list)
      (flymake-goto-next-error)
    (flyspell-goto-next-error)))

(defun goto-prev-problem()
  (interactive)
  (if (member 'flymake-mode minor-mode-list)
      (flymake-goto-prev-error)
    (flyspell-goto-previous-error)))


(global-set-key (kbd "C-c e n") 'goto-next-problem)
(global-set-key (kbd "C-c e p") 'goto-prev-problem)


(require 'flymake-cursor)

;; eof
