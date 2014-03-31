;; -*- coding: utf-8 -*-

(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "deutsch") "en" "deutsch")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)))

(add-hook 'mail-mode-hook 'flyspell-mode)
(add-hook 'markdown-mode-hook 'flyspell-mode)
(add-hook 'rst-mode-hook 'flyspell-mode)

;; eof
