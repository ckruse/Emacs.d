;; -*- coding: utf-8 -*-

(define-key notmuch-search-mode-map "d"
  (lambda ()
    "toggle deleted tag for thread"
    (interactive)
    (if (member "deleted" (notmuch-search-get-tags))
        (notmuch-search-tag '("-deleted"))
      (notmuch-search-tag '("+deleted" "-inbox" "-unread")))))

(define-key notmuch-search-mode-map "!"
  (lambda ()
    "toggle unread tag for thread"
    (interactive)
    (if (member "unread" (notmuch-search-get-tags))
        (notmuch-search-tag '("-unread"))
      (notmuch-search-tag '("+unread")))))


(define-key notmuch-show-mode-map "d"
  (lambda ()
    "toggle deleted tag for message"
    (interactive)
    (if (member "deleted" (notmuch-show-get-tags))
        (notmuch-show-tag '("-deleted"))
      (notmuch-show-tag '("+deleted" "-inbox" "-unread")))))


(setq notmuch-search-oldest-first nil
      message-sendmail-envelope-from 'header
      mail-specify-envelope-from 'header
      mail-envelope-from 'header
      notmuch-show-all-multipart/alternative-parts nil
      mime-edit-split-message nil
      mime-edit-pgp-signers '("C84EF897")
      mime-edit-pgp-encrypt-to-self t
      message-send-mail-function 'message-send-mail-with-sendmail
      sendmail-program "~/dev/mail/msmtp-enqueue.sh"
      message-sendmail-f-is-evil nil
      mail-interactive t
      user-full-name "Christian Kruse"
      user-mail-address "cjk@defunct.ch"
      message-kill-buffer-on-exit t
      mail-user-agent 'message-user-agent
      notmuch-fcc-dirs '(("cjk@defunct.ch" . "Defunct/Sent")
                         ("cjk@wwwtech.de" . "Defunct/Sent")
                         ("c.kruse@termitel.de" . "Termitel/Sent")
                         ("c.kruse@mwbenson.de" . "Termitel/Sent")
                         ("c.kruse@mwbenson.ch" . "Termitel/Sent")
                         ("c.kruse@sourceflow.ch" . "Termitel/Sent")
                         (".*" . "Defunct/Sent")))

(add-hook 'message-setup-hook 'mml-secure-sign-pgpmime)

(require 'gnus-alias)
(setq gnus-alias-debug-buffer-name 1)
;(add-hook 'message-setup-hook 'gnus-alias-determine-identity)
;(setq gnus-alias-unknown-identity-rule 'gnus-alias-select-identity)

(defun ck/choose-identity ()
  (interactive)
  (let ((ident (gnus-alias-determine-identity t)))
    (if (not (equal ident ""))
        (gnus-alias-select-identity ident)
      (gnus-alias-select-identity))))

(add-hook 'message-setup-hook 'ck/choose-identity)
 
(setq gnus-alias-identity-alist
      '(("Defunct"
         nil ;; Does not refer to any other identity
         "Christian Kruse <cjk@defunct.ch>" ;; Sender address
         nil ;; No organization header
         (("Fcc" . " ~/Mail/Defunct/Sent"))
         nil ;; No extra body text
         "~/dev/mail/signature-defunct")
        ("Termitel"
         nil
         "Christian Kruse <c.kruse@termitel.de>"
         "Termitel GmbH"
         (("Fcc" . " ~/Mail/Termitel/Sent"))
         nil
         "~/dev/mail/signature-termitel")))

;;(setq gnus-alias-default-identity "Defunct")
;; Define rules to match work identity
(setq gnus-alias-identity-rules
      '(("Termitel" ("any" "c.kruse@\\(termitel\\.de\\|mwbenson\\.de\\|mwbenson\\.ch\\|sourceflow\\.ch\\)" both) "Termitel")))

;; eof
