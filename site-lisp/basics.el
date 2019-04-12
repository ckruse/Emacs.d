(setq backup-inhibited t)
(setq-default backup-inhibited t)

(setq auto-save-default nil)
(setq-default auto-save-default nil)

(setq auto-save-list-file-prefix nil)
(setq-default auto-save-list-file-prefix nil)

(setq create-lockfiles nil)

;; start emacs server
(load "server")
(unless (server-running-p)
  (server-start))

;; no one needs the startup message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; browse URLs
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "xdg-open")

;; show time and date in status bar
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-default-load-average nil)

(display-time)

;; show line and column number
(line-number-mode t)
(column-number-mode t)

;; sane tab handling
(setq tab-width 2)
(setq-default tab-width 2)
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

;; global font locking with max decorations
(when (fboundp 'global-font-lock-mode)
  (setq font-lock-maximum-decoration t)
  (global-font-lock-mode t))

;; we wanna use utf8 normally
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)

;; don't ring the bell
(setq ring-bell-function 'ignore)

;; Use y-or-n-p instead of yes-or-no-p
(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)

;; disabled commands: re-enable them
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; I'd like to use the clipboard buffer on X11.
(setq x-select-enable-clipboard t)

;; I'd also like to overwrite an active region with a yank.
(delete-selection-mode t)

;; When we copy something from an external application and then use cut
;; in Emacs, the copied content is not in the kill ring. This changes
;; that behaviour:
(setq save-interprogram-paste-before-kill t)

;; indent on enter
(global-set-key (kbd "RET") 'newline-and-indent)

;; highlight current line
(global-hl-line-mode t)

;; disable blinking cursor
(blink-cursor-mode 0)


(when (boundp 'ns-pop-up-frames)
  (setq ns-pop-up-frames nil))

(setq visible-bell t)
(setq line-move-visual nil)
(setq track-eol t)

(which-function-mode)
(setq which-func-modes '(ruby-mode emacs-lisp-mode js-mode js2-mode c-mode php-mode elixir-mode))

(defun set-exec-path-from-shell-PATH ()
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $PATH' 2>/dev/null"))))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))
(set-exec-path-from-shell-PATH)

(provide 'basics)
