;; -*- coding: utf-8 -*-

(require 'helm-dash)

(defun ruby-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Ruby" "Ruby On Rails")))

(add-hook 'ruby-mode-hook 'ruby-doc)

(defun c-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("C" "C++")))

(add-hook 'c-mode-hook 'c-doc)
(add-hook 'c++-mode-hook 'c-doc)

(defun web-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("HTML" "JavaScript" "CSS" "Ruby" "PHP" "Ruby on Rails")))

(add-hook 'web-mode-hook 'web-mode-doc)

(defun js-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("JavaScript")))

(add-hook 'js-mode-hook 'js-mode-doc)

(defun php-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("PHP")))

(add-hook 'php-mode-hook 'php-mode-doc)

(defun sql-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("PostgreSQL")))

(add-hook 'sql-mode-hook 'sql-mode-doc)

(defun sh-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Bash")))

(add-hook 'sh-mode-hook 'sh-mode-doc)

(defun emacs-lisp-mode-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Emacs Lisp")))

(add-hook 'emacs-lisp-mode-hook 'emacs-lisp-mode-doc)

(global-set-key [f1] 'helm-dash-at-point)

;; eof
