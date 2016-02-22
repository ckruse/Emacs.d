;; -*- coding: utf-8 -*-

(require 'nnir)

(setq gnus-select-method
      '(nnimap "Defunct"
                      (nnimap-address "jugulator.defunced.de")
                      (nnimap-server-port 143)
                      (nnimap-stream starttls)
                      (nnir-search-engine imap)))

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "Termitel"
                      (nnimap-address "newton.termitel.de")
                      (nnimap-server-port 143)
                      (nnimap-stream starttls)
                      (nnir-search-engine imap)))

(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number))

      gnus-treat-display-smileys nil
      gnus-use-cache t
      gnus-cache-directory "~/.local/cache/gnus/"
      gnus-cache-remove-articles '()
      gnus-cache-enter-articles '(ticked dormant unread read)
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-subject
      gnus-thread-hide-subtree t
      gnus-thread-ignore-subject t
      user-full-name "Christian Kruse"
      user-mail-address "cjk@defunct.ch"
      mm-text-html-renderer 'shr
      gnus-use-correct-string-widths nil
      gnus-permanently-visible-groups ".*"
      gnus-parameters '((".*"
                         (display . all)))
      gnus-large-newsgroup 500

      message-kill-buffer-on-exit t
      mail-user-agent 'message-user-agent

      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "~/dev/mail/msmtp-enqueue.sh"
      message-sendmail-f-is-evil nil
      mail-interactive t
      message-sendmail-envelope-from 'header
      mail-specify-envelope-from 'header
      mail-envelope-from 'header
      mime-edit-pgp-signers '("C84EF897")
      mime-edit-pgp-encrypt-to-self t
      mml2015-encrypt-to-self t
      mml2015-sign-with-sender t
      gnus-gcc-mark-as-read t
      message-user-fqdn "jugulator.defunced.de")

(gnus-demon-add-handler 'gnus-group-get-new-news 2 t)
(gnus-demon-init)

(add-hook 'message-mode-hook 'turn-on-flyspell)

(eval-after-load 'gnus-topic
  '(progn
     (setq gnus-topic-topology '(("Gnus" visible)
                                 (("Inbox" visible nil nil))
                                 (("Defunct" visible nil nil))
                                 (("Termitel" visible nil nil))
                                 (("Lists" visible nil nil))
                                 (("misc")))
           gnus-topic-alist '(("Inbox" "INBOX" "nnimap+Termitel:INBOX")
                              ("Defunct" "Archiv" "Sent" "Drafts" "Trash")
                              ("Termitel" ; the key of topic
                               "nnimap+Termitel:Archiv"
                               "nnimap+Termitel:Sent"
                               "nnimap+Termitel:Trash"
                               "nnimap+Termitel:Drafts"
                               "nnimap+Termitel:Log Alphatier"
                               "nnimap+Termitel:Notes")
                              ("Lists"
                               "Lists.phoenix.talk"
                               "Lists.arch.announce" "Lists.arch.general" "Lists.arch.dev-public"
                               "Lists.ccc.chaos-west" "Lists.ccc.chaostreff" "Lists.ccc.raif-intern"
                               "Lists.ccc.warpzone" "Lists.ccc.warpzone-intern"
                               "Lists.emacs.devel" "Lists.emacs.help" "Lists.emacs.org-mode"
                               "Lists.gnome.devel"
                               "Lists.pg.hackers" "Lists.pg.committers" "Lists.pg.announce"
                               "Lists.pg.admin" "Lists.pg.bugs" "Lists.pg.www"
                               "Lists.phoenix.core"
                               "Lists.arch.security"
                               "Lists.cforum"
                               "Lists.gnome.contacts" "Lists.rails.security")
                              ("misc" ; the key of topic
                               "nndraft:drafts"
                               "INBOX.spam")
                              ("Gnus")))))

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)


(require 'gnus-alias)

(setq gnus-alias-debug-buffer-name 1)

(defun ck/choose-identity ()
  (interactive)
  ;; (let ((ident (gnus-alias-determine-identity t)))
  ;;   (if (not (equal ident ""))
  ;;       (gnus-alias-use-identity ident)
  (gnus-alias-select-identity) ;;)

  (goto-char (point-min))
  (search-forward "-- \n")
  (goto-char (- (point) 4))
  (insert "\nFreundliche Grüsse,\n")

  (mml-secure-message-sign-pgpmime)) ;;)

(add-hook 'gnus-message-setup-hook 'ck/choose-identity)
;(add-hook 'gnus-message-setup-hook #'mml-secure-message-sign)


(setq gnus-alias-identity-alist
      '(("Defunct"
         nil ;; Does not refer to any other identity
         "Christian Kruse <cjk@defunct.ch>" ;; Sender address
         nil ;; No organization header
         (("Gcc" . "nnimap+Defunct:Sent"))
         nil ;; No extra body text
         "~/dev/mail/signature-defunct")
        ("Termitel"
         nil
         "Christian Kruse <c.kruse@termitel.de>"
         "Termitel GmbH"
         (("Gcc" . "nnimap+Termitel:Sent"))
         nil
         "~/dev/mail/signature-termitel")))

(setq gnus-alias-identity-rules
      '(("Defunct"  ("any" "\\(cjk\\|c.kruse\\|ckruse\\)@\\(defunct\\.ch\\|wwwtech\\.de\\)" both) "Defunct")
        ("Termitel" ("any" "c.kruse@\\(termitel\\.de\\|mwbenson\\.de\\|mwbenson\\.ch\\|sourceflow\\.ch\\)" both) "Termitel")))


(defun ck/archive-article ()
  (interactive)

  (if (string-prefix-p "nnimap+Termitel:" gnus-newsgroup-name)
      (gnus-summary-move-article nil "nnimap+Termitel:Archiv" nil)
    (gnus-summary-move-article nil "Archiv" nil)))

(defun ck/delete-article ()
  (interactive)

  (if (string-prefix-p "nnimap+Termitel:" gnus-newsgroup-name)
      (gnus-summary-move-article nil "nnimap+Termitel:Trash" nil)
    (gnus-summary-move-article nil "Trash" nil)))

(define-key gnus-summary-mode-map "y"
  (defhydra hydra-gnus-group (:color blue)
    "Gnus action"
    ("a" ck/archive-article "Archive")
    ("d" ck/delete-article "Trash")
    ("f" gnus-summary-mail-forward "Forward")))

;; eof
