(setq load-path (cons "~/.emacs.d/org/lisp" load-path))
(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

(setq org-directory "~/Dokumente/org")
(setq org-mobile-directory "/scpc:ckruse@jugulator.defunced.de:/home/ckruse/org")
(setq org-agenda-files (quote ("~/Dokumente/org/inbox.org" "~/Dokumente/org/projects.org")))
(setq org-mobile-inbox-for-pull "~/Dokumente/org/inbox.org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(add-hook 'org-mode-hook 'turn-on-font-lock)

;; eof
