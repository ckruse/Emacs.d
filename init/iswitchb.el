;; -*- coding: utf-8 -*-

(defun iswitchb-my-keys ()
  (define-key iswitchb-mode-map (kbd "<right>") 'iswitchb-next-match)
  (define-key iswitchb-mode-map (kbd "<left>") 'iswitchb-prev-match))

(add-hook 'iswitchb-define-mode-map-hook 'iswitchb-my-keys)

(iswitchb-mode 1)

;; eof
