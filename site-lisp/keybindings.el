;; -*- coding: utf-8 -*-

(use-package general
  :ensure t
  :config
  (general-define-key :keymaps 'helm-map
                      "<tab>" 'helm-execute-persistent-action
                      "C-i" 'helm-execute-persistent-action
                      "C-z" 'helm-select-action)

  (general-define-key "M-y" 'helm-show-kill-ring
                      "C-x b" 'helm-mini
                      "M-x" #'helm-M-x
                      "C-x r b" #'helm-filtered-bookmarks
                      "C-x C-f" #'helm-find-files
                      "C-x K" 'ck/kill-all-buffers

                      "s-<up>" 'beginning-of-buffer
                      "s-<down>" 'end-of-buffer

                      "s-u" 'revert-buffer
                      "C--" 'dabbrev-expand
                      "C-x o" 'ace-window
                      "C-x C-b" 'ibuffer)

  (general-create-definer ck/leader-def
    :prefix "C-c c")

  (ck/leader-def "f"
    (defhydra often-used-files (:color blue)
      "often used files"
      ("p" (find-file "~/Documents/org/passwords.org.gpg") "open passwords file")
      ("i" (find-file "~/Documents/org/inbox.org") "Open org-mode inbox file")
      ("t" (find-file "~/Documents/org/work/termitel.org") "Open termitel org-mode file")))

  (ck/leader-def "e"
    (defhydra expand-region (:color red)
      "expand region as a hydra"
      ("e" er/expand-region "Expand region")
      ("s" er/contract-region "Shrink region")))

  (ck/leader-def "m"
    (defhydra multicursor (:color red)
      "multicursor"
      ("v" mc/edit-lines "all lines")
      ("d" mc/mark-next-like-this "next match")
      ("p" mc/mark-previous-like-this "prev match")
      ("D" mc/mark-all-like-this "all matches")
      ("h" mc-hide-unmatched-lines-mode "hide unmatched lines")))

  (ck/leader-def "l"
    (defhydra launchers (:color blue)
      "Launchers"
      ("c" calc "Calc")
      ("d" ediff-buffers "ediff")
      ("f" find-dired "find-dired")
      ("g" lgrep "lgrep")
      ("G" rgrep "rgrep")
      ("h" man "man")
      ("s" eshell-here "eshell")
      ("t" git-timemachine "git timemachine")
      ("a" magit-status "magit-status")
      ("p" sql-postgres "sql-postgres")
      ("w" whitespace-mode "toggle whitespaces")
      ("x" ck/xml-format "reformat XML")
      ("." ck-put-file-name-wo-path-on-clipboard "copy filename to clipboard")
      (":" ck-put-file-name-on-clipboard "copy filename with full path to clipboard")))

  (ck/leader-def "C-c" 'ck/comment-line-or-region)

  (ck/leader-def "o"
    (defhydra org (:color blue)
      "org actions"
      ("a" org-agenda "Agenda")
      ("l" org-store-link "Store link")
      ("b" org-iswitchb "Org switch buffer")
      ("A" org-archive-subtree "Archive subtree" :color red)

      ("c" org-capture "Capture")
      ("i" org-clock-in "Punch in")
      ("o" org-clock-out "Punch out")
      ("g" org-clock-goto "Goto clock")

      ;("p" org-publish-all "Publish")
      ("t" ck/org-tags "list tags"))))



(provide 'keybindings)
