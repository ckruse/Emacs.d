;; -*- coding: utf-8 -*-

(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("Org" (or
                       (mode . org-mode)))
               ("emacs" (or
                         (name . "^\\*scratch\\*$")
                         (name . "^\\*Messages\\*$")
                         (name . "^\\*Help\\*$")
                         (name . "^\\*Flycheck error messages\\*$")))
               ("wanderlust" (or
                              (mode . wl-folder-mode)
                              (mode . wl-summary-mode)
                              (mode . mime-view-mode)))))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; eof
