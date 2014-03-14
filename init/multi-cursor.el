;; -*- coding: utf-8 -*-

(require 'multiple-cursors)

(global-set-key (kbd "C-c v") 'mc/edit-lines)
(global-set-key (kbd "C-c C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c M-d") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c D") 'mc/mark-all-like-this)

;; eof
