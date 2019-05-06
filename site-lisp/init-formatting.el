(use-package format-all
  :ensure t
  :commands (format-all-mode format-all-buffer)
  :init
  (add-hook 'js2-mode-hook 'format-all-mode))

(provide 'init-formatting)
