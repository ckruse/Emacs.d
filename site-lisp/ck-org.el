
(use-package org
  :ensure org-plus-contrib
  :commands org-mode org-agenda org-capture
  :init
  (add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

  (setq org-directory "~/Documents/org"
        org-mobile-directory "/scp:nginx@cloud.defunct.ch:/var/www/org-mobile/"
        org-agenda-files '("~/Documents/org/inbox.org"
                           "~/Documents/org/priv/projects.org"
                           "~/Documents/org/priv/todo.org"
                           "~/Documents/org/priv/notes.org"
                           "~/Documents/org/work/termitel.org"
                           "~/Documents/org/work/termitel-someday.org")
        org-mobile-inbox-for-pull "~/Documents/org/inbox.org"
        org-default-notes-file (concat org-directory "/inbox.org")

        org-log-into-drawer t

        org-agenda-start-with-follow-mode t

        org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                            (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))

        org-use-fast-todo-selection t
        org-treat-S-cursor-todo-selection-as-state-change nil
        org-todo-state-tags-triggers '(("CANCELLED" ("CANCELLED" . t))
                                       ("WAITING" ("WAITING" . t))
                                       ("HOLD" ("WAITING") ("HOLD" . t))
                                       (done ("WAITING") ("HOLD"))
                                       ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
                                       ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
                                       ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))

        org-capture-templates '(("t" "todo" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
                                 "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
                                ("n" "note" entry (file+headline "~/Documents/org/notes.org" "Notizen")
                                 "* %?\n%U\n" :clock-in t :clock-resume t)
                                ("w" "blog entry" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
                                 "* TODO %? :blog:\n%U\n" :clock-in t :clock-resume t)
                                ("j" "Journal" entry (file+datetree "~/Documents/org/priv/diary.org")
                                 "* %?\n%U\n" :clock-in t :clock-resume t)
                                ("k" "Körpermaße" entry (file+datetree "~/Documents/org/priv/measurements.org")
                                 "* %?\n%U\n")
                                ("m" "Meeting" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
                                 "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
                                ("c" "Phone call" entry (file+headline "~/Documents/org/inbox.org" "Inbox")
                                 "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
                                ("p" "password" entry (file "~/Documents/org/passwords.gpg")
                                 "* %^{Title}\n  %^{URL}p %^{USERNAME}p %^{PASSWORD}p"))

        org-refile-targets '((nil :maxlevel . 2)
                             (org-agenda-files :maxlevel . 2))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-refile-allow-creating-parent-nodes 'confirm

        org-agenda-custom-commands '(("f" "FLOSS" tags-todo ":private:foss:"
                                      ((org-agenda-overriding-header "FLOSS")))
                                     ("t" "Priv-TODOs" tags-todo ":private:todo:"
                                      ((org-agenda-overriding-header "Priv-TODOs")))
                                     ("w" "Work todos" tags-todo "+work+termitel-someday-ettlingen"
                                      ((org-agenda-overriding-header "Work todos")))
                                     ("s" "Work todos: someday" tags-todo "+work+termitel+someday-ettlingen"
                                      ((org-agenda-overriding-header "Work todos: someday")))
                                     ("e" "Work todos: Ettlingen" tags-todo "+work+termitel+ettlingen"
                                      ((org-agenda-overriding-header "Work todos: Ettlingen"))))
        )

  (add-hook 'org-mode-hook 'turn-on-font-lock)
  )

(use-package org-bullets
  :ensure t
  :commands org-bullets-mode
  :after org
  :init
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(provide 'ck-org)
