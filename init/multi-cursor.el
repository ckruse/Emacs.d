;; -*- coding: utf-8 -*-

(require 'multiple-cursors)

(global-set-key (kbd "C-c v") 'mc/edit-lines)
(global-set-key (kbd "C-c C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c M-d") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c D") 'mc/mark-all-like-this)

(defun overwrite-keys-mc ()
  (local-set-key (kbd "C-c v") 'mc/edit-lines)
  (local-set-key (kbd "C-c C-d") 'mc/mark-next-like-this)
  (local-set-key (kbd "C-c M-d") 'mc/mark-previous-like-this)
  (local-set-key (kbd "C-c D") 'mc/mark-all-like-this)

  (global-set-key (kbd "C-c v") 'mc/edit-lines)
  (global-set-key (kbd "C-c C-d") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c M-d") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c D") 'mc/mark-all-like-this))

(add-hook 'web-mode-hook 'overwrite-keys-mc)
(add-hook 'php-mode-hook 'overwrite-keys-mc)
(add-hook 'c-mode-hook 'overwrite-keys-mc)
(add-hook 'ruby-mode-hook 'overwrite-keys-mc)
(add-hook 'sass-mode-hook 'overwrite-keys-mc)

;; eof
