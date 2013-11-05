;; -*- coding: utf-8 -*-

(setq load-path  (cons (expand-file-name "~/.emacs.d/site-lisp/") load-path))
(load "~/.emacs.d/package.el")

(load "~/.emacs.d/emulate-mac-keyboard-mode.el")
(emulate-mac-german-keyboard-mode)

(dolist (f (directory-files "~/.emacs.d/init/" t "\\.el$"))
  (load f))

(load "~/.emacs.d/tweeks.el")
(load "~/.emacs.d/keybinding.el")

(server-start)

;; ;; eof
