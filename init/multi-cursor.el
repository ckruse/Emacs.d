;; -*- coding: utf-8 -*-

(require 'multiple-cursors)

(global-set-key (kbd "C-v") 'mc/edit-lines)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-M-d") 'mc/mark-previous-like-this)
(global-set-key (kbd "M-d") 'mc/mark-all-like-this)

;; eof
