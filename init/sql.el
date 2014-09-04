;; -*- coding: utf-8 -*-

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (toggle-truncate-lines t)))

(add-hook 'sql-mode-hook 'sqlup-mode)
(add-hook 'sql-interactive-mode-hook 'sqlup-mode)

(global-set-key (kbd "C-c u") 'sqlup-capitalize-keywords-in-region)

;; eof
