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
;;(add-hook 'c-mode-hook 'flymake-mode)

(setq flymake-log-level 0)
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

;; (defun flymake-postgres-init ()
;;   (flymake-simple-make-init-impl
;;    'flymake-create-temp-inplace nil nil
;;    buffer-file-name
;;    'flymake-get-postgres-cmdline))

;; (defun flymake-get-postgres-cmdline (source base-dir)
;;   `("make" ("-C",
;;             (concat "/home/andres/build/postgres/dev-assert/vpath/"
;;                     (file-relative-name base-dir "/home/andres/src/postgresql")),
;;             "SYNTAX_CHECK_MODE=1", "check-syntax-vpath",
;;             (concat "CHK_SOURCES=" source))
;; 	)
;;   )

;; (push '("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'" flymake-postgres-init)
;; 	  flymake-allowed-file-name-masks)

(require 'flymake-cursor)

;; eof
