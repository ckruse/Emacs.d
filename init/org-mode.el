(setq load-path (cons "~/.emacs.d/org/lisp" load-path))
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

(setq org-directory "~/BTSync/org")
(setq org-mobile-directory "~/BTSync/MobileOrg/")
(setq org-agenda-files (quote ("~/BTSync/org/inbox.org" "~/BTSync/org/projects.org")))
(setq org-mobile-inbox-for-pull "~/BTSync/org/inbox.org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(add-hook 'org-mode-hook 'turn-on-font-lock)

;; eof
