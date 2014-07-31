;(require 'org-install)

(setq load-path (cons "/usr/share/emacs/site-lisp/org" load-path))
(require 'org-loaddefs)
(require 'org-agenda)

;; Explicitly load required exporters
(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)


(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\)$" . org-mode))

(setq org-directory "~/Dokumente/org")
(setq org-mobile-directory "/scpc:ckruse@jugulator.defunced.de:/var/www/cloud.defunct.ch/htdocs/org")
(setq org-agenda-files (quote ("~/Dokumente/org/" "~/Dokumente/org/priv"
                               "~/Dokumente/org/work" "~/Dokumente/org/foss")))
(setq org-mobile-inbox-for-pull "~/Dokumente/org/inbox.org")
(setq org-default-notes-file (concat org-directory "/inbox.org"))

(add-hook 'org-mode-hook 'turn-on-font-lock)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)"
                        "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

;; use C-c C-t <KEY> for fast selection of todo state
(setq org-use-fast-todo-selection t)

(setq org-treat-S-cursor-todo-selection-as-state-change nil)


(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dokumente/org/inbox.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/Dokumente/org/inbox.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/Dokumente/org/inbox.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/Dokumente/org/priv/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/Dokumente/org/inbox.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/Dokumente/org/inbox.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/Dokumente/org/inbox.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/Dokumente/org/inbox.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))


;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at "LOGBOOK" (point))))

(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)


(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-ca" 'org-archive-subtree)
(global-set-key (kbd "M-+") 'org-capture)

(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)


;;;;;;;;;;;;;;;;;
;; clock setup ;;
;;;;;;;;;;;;;;;;;

;;
;; Resume clocking task when emacs is restarted
(org-clock-persistence-insinuate)
;;
;; Show lot of clocking history so it's easy to pick items off the C-F11 list
(setq org-clock-history-length 23)
;; Resume clocking task on clock-in if the clock is open
(setq org-clock-in-resume t)
;; Change tasks to NEXT when clocking in
(setq org-clock-in-switch-to-state 'bh/clock-in-to-next)
;; Separate drawers for clocking and logs
(setq org-drawers (quote ("PROPERTIES" "LOGBOOK")))
;; Save clock data and state changes and notes in the LOGBOOK drawer
(setq org-clock-into-drawer t)
;; Sometimes I change tasks I'm clocking quickly - this removes clocked tasks with 0:00 duration
(setq org-clock-out-remove-zero-time-clocks t)
;; Clock out when moving task to a done state
(setq org-clock-out-when-done t)
;; Save the running clock and all clock history when exiting Emacs, load it on startup
(setq org-clock-persist t)
;; Do not prompt to resume an active clock
(setq org-clock-persist-query-resume nil)
;; Enable auto clock resolution for finding open clocks
(setq org-clock-auto-clock-resolution (quote when-no-clock-is-running))
;; Include current clocking task in clock reports
(setq org-clock-report-include-clocking-task t)

(setq bh/keep-clock-running nil)

(defvar bh/organization-task-id "BADA377F-DABB-4C51-BC7B-99C574DCE45D")

(add-hook 'org-clock-out-hook 'bh/clock-out-maybe 'append)


;;;;;;;;;;;;;;;
;; exporting ;;
;;;;;;;;;;;;;;;

(setq org-alphabetical-lists t)

(setq org-html-inline-images t)
; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)
; Increase default number of headings to export
(setq org-export-headline-levels 6)
; disable sup/sub scripts
(setq org-use-sub-superscripts nil)

(setq org-html-doctype "html5")
(setq org-html-head-include-default-style nil)

;;(setq debug-on-error t)
(setq org-publish-project-alist
      ;
      ; Termitel Todo list
      ; org-mode-doc-org this document
      ; org-mode-doc-extra are images and css files that need to be included
      ; org-mode-doc is the top-level project that gets published
      ; This uses the same target directory as the 'doc' project
      (quote (("termitel"
               :base-directory "~/Dokumente/org/work/"
               :publishing-directory "/ssh:ckruse@jugulator.defunced.de:/var/www/cloud.defunct.ch/htdocs/todo/termitel"
               :recursive t
               :section-numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function (org-html-publish-to-html org-org-publish-to-org)
               :html-head "<link rel=\"stylesheet\" href=\"http://cloud.defunct.ch/todo/org.css\" type=\"text/css\">"
               :plain-source t
               :htmlized-source t
               :style-include-default nil
               :auto-sitemap t
               :sitemap-filename "index.html"
               :sitemap-title "Termitel TODO"
               :sitemap-style "tree"
               :author-info t
               :creator-info t)

              ("foss"
               :base-directory "~/Dokumente/org/foss/"
               :publishing-directory "/ssh:ckruse@jugulator.defunced.de:/var/www/cloud.defunct.ch/htdocs/todo/foss"
               :recursive t
               :section-numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function (org-html-publish-to-html org-org-publish-to-org)
               :html-head "<link rel=\"stylesheet\" href=\"http://cloud.defunct.ch/todo/org.css\" type=\"text/css\">"
               :plain-source t
               :htmlized-source t
               :style-include-default nil
               :auto-sitemap t
               :sitemap-filename "index.html"
               :sitemap-title "FOSS TODO"
               :sitemap-style "tree"
               :author-info t
               :creator-info t)

              ("private"
               :base-directory "~/Dokumente/org/"
               :publishing-directory "/ssh:ckruse@jugulator.defunced.de:/var/www/cloud.defunct.ch/htdocs/todo/private"
               :recursive t
               :section-numbers nil
               :table-of-contents nil
               :base-extension "org"
               :publishing-function (org-html-publish-to-html org-org-publish-to-org)
               :html-head "<link rel=\"stylesheet\" href=\"http://cloud.defunct.ch/todo/org.css\" type=\"text/css\">"
               :plain-source t
               :htmlized-source t
               :style-include-default nil
               :auto-sitemap t
               :sitemap-filename "index.html"
               :sitemap-title "Privat TODO"
               :sitemap-style "tree"
               :author-info t
               :creator-info t
               :exclude "passwords\\|work\\|foss"))))



;;;;;;;;;;;;;;;;;;
;; refile setup ;;
;;;;;;;;;;;;;;;;;;

(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))
(setq org-refile-use-outline-path t)
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes (quote confirm))
(setq org-completion-use-ido t)


;; eof
