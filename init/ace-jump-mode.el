;; -*- coding: utf-8 -*-

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;;
;; enable a more powerful jump back function from ace jump mode
;;
(ace-jump-mode-enable-mark-sync)
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;; eof
