;; -*- mode: emacs-lisp -*-

(require 'w3m)
(require 'mime-w3m)

(setq
 elmo-maildir-folder-path "~/Mail"

 wl-stay-folder-window t                       ;; show the folder pane (left)
 wl-folder-window-width 35                     ;; toggle on/off with 'i'
 wl-summary-width 200
 wl-summary-line-format "%n%T%P %D/%M (%W) %h:%m %t%[%25(%c %f%) %] %s"
 wl-thread-insert-opened t
 wl-thread-open-reading-thread t

 mime-edit-split-message nil
 mime-edit-pgp-signers '("C84EF897")

 ;;wl-smtp-posting-server "localhost"            ;; put the smtp server here
 wl-local-domain "defunct.ch"          ;; put something here...
 wl-message-id-domain "defunct.ch"     ;; ...

 ;;wl-from "Christian Kruse <cjk@defunct.ch>"                  ;; my From:
 wl-user-mail-address-list (quote ("cjk@defunct.ch" "cjk@wwwtech.de"
                                   "c.kruse@termitel.de"))

 wl-forward-subject-prefix "Fwd: "
 wl-insert-message-id nil
 ;signature-insert-at-eof t
 ;signature-delete-blank-lines-at-eof t

 ;; note: all below are dirs (Maildirs) under elmo-maildir-folder-path
 ;; the '.'-prefix is for marking them as maildirs
 wl-fcc ".Defunct/Sent"
 wl-fcc-force-as-read t
 wl-default-folder ".Defunct/INBOX"
 wl-draft-folder ".Defunct/Drafts"
 wl-trash-folder ".Defunct/Trash"
 wl-spam-folder ".Defunct/Trash"
 wl-queue-folder ".Defunct/Drafts"
 wl-temporary-file-directory "~/.cache/wl"

 ;; check this folder periodically, and update modeline
 wl-biff-check-folder-list '(".Defunct/INBOX" ".Termitel/INBOX") ;; check every 180 seconds
 ;; (default: wl-biff-check-interval)

 global-mode-string (cons
                     '(wl-modeline-biff-status
                       wl-modeline-biff-state-on
                       wl-modeline-biff-state-off)
                     global-mode-string)

 ;; hide many fields from message buffers
 wl-message-ignored-field-list '("^.*:")
 wl-message-visible-field-list
 '("^\\(To\\|Cc\\):"
   "^Subject:"
   "^\\(From\\|Reply-To\\):"
   "^Organization:"
   "^Message-Id:"
   "^\\(Posted\\|Date\\):"
   "^X-Mailer:"
   "^X-\\(Face\\(-[0-9]+\\)?\\|Weather\\|Fortune\\|Now-Playing\\):"
   )
 wl-message-sort-field-list
 '("^From"
   "^Organization:"
   "^X-Attribution:"
   "^Subject"
   "^Date"
   "^To"
   "^Cc"))

(setq wl-draft-send-mail-function 'sendmail-send-it
      sendmail-program "/home/ckruse/dev/mail/msmtp-enqueue.sh"
      message-sendmail-extra-arguments "-a Defunct"
      message-send-mail-function 'message-send-mail-with-sendmail
      mail-specify-envelope-from t
      message-sendmail-f-is-evil nil
      mail-envelope-from 'header
      mail-interactive nil
      message-sendmail-envelope-from 'header)

;; sort method: reverse date
(defun wl-summary-overview-entity-compare-by-rdate (x y)
  (not (wl-summary-overview-entity-compare-by-date x y)))
(add-to-list 'wl-summary-sort-specs 'rdate)

(defun wl-summary-sort-by-rdate ()
  (interactive)
  (wl-summary-rescan "rdate")
  (goto-char (point-min)))

(defadvice wl-summary-rescan (after wl-summary-rescan-move-cursor activate)
  (if (string-match "^r" (ad-get-arg 0))
      (goto-char (point-min))))

;; sort the summary by defaut by reversed date
(defun my-wl-summary-sort-hook ()
  (wl-summary-rescan "rdate"))

(add-hook 'wl-summary-prepared-hook 'my-wl-summary-sort-hook)


;; mail checks (subject, attachment)
;; suggested by Masaru Nomiya on the WL mailing list
(defun djcb-wl-draft-subject-check ()
  "check whether the message has a subject before sending"
  (if (and (< (length (std11-field-body "Subject")) 1)
           (null (y-or-n-p "No subject! Send current draft?")))
      (error "Abort.")))


;; note, this check could cause some false positives; anyway, better
;; safe than sorry...
(defun djcb-wl-draft-attachment-check ()
  "if attachment is mention but none included, warn the the user"
  (save-excursion
    (goto-char 0)
    (unless ;; don't we have an attachment?
      (re-search-forward "^Content-Disposition: attachment" nil t) 
      (when ;; no attachment; did we mention an attachment?
          (or
           (re-search-forward "attach" nil t)
           (re-search-forward "anbei" nil t)
           (re-search-forward "Anhang" nil t)
           (re-search-forward "angehängt" nil t))
        (unless (y-or-n-p "Possibly missing an attachment. Send current draft?")
          (error "Abort."))))))

(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-subject-check)
(add-hook 'wl-mail-send-pre-hook 'djcb-wl-draft-attachment-check)

;;;;;;;
;;;;;;; Multiple account management
;;;;;;;

;; How messages with disposal mark ("d") are to be handled.
;; remove = instant removal (same as "D"), thrash = move to wl-trash-folder
;; string = move to string.
(setq wl-dispose-folder-alist
      '(("^%.*termitel\\.de" . ".Termitel/Trash")
        ("^%.*defunct\\.ch" . ".Defunct/Trash")
        ("^%.*wwwtech\\.de" . ".Defunct/Trash")))

;; select correct email address when we _start_ writing a draft.
(add-hook 'wl-mail-setup-hook 'wl-draft-config-exec)

;; don't apply the templates when sending the draft otherwise 
;; choosing another template with C-c C-j won't have any effect
(remove-hook 'wl-draft-send-hook 'wl-draft-config-exec)


;;is run when wl-draft-send-and-exit or wl-draft-send is invoked:
;;(NOTE: "M-: wl-draft-parent-folder" => %INBOX:myname/clear@imap.gmail.com:993)
(setq wl-draft-config-alist
      '(((string-match "Termitel" wl-draft-parent-folder)
         (template . "work")
         (message-sendmail-extra-arguments . "-a Termitel")
         (wl-local-domain . "mail.termitel.de")
         (wl-message-id-domain . "mail.termitel.de")
         (wl-draft-folder . ".Termitel/Drafts")
         ("Fcc" . ".Termitel/Sent"))
        ((string-match "Defunct" wl-draft-parent-folder)
         (template . "private")
         (message-sendmail-extra-arguments . "-a Defunct")
         (wl-local-domain . "tyr.defunct.ch")
         (wl-message-id-domain . "defunct.ch"))))

;;choose template with C-c C-j
(setq wl-template-alist
      '(("private"
         (wl-from . "Christian Kruse <cjk@defunct.ch>")
         ("From" . wl-from))
        ("work"
         (wl-from . "Christian Kruse <c.kruse@termitel.de>")
         ("From" . wl-from))))


;; Use different signature files based on From: address
;; (setq mime-edit-signature-alist
;;       `((("From" . "termitel.de") . (lambda ()
;;                                       (get-string-from-file "~/dev/mail/signature-termitel")))
;;         (("From" . "defunct.ch") . (lambda ()
;;                                      (get-string-from-file "~/dev/mail/signature-defunct")))))

;;Cycle through templates with arrow keys
(define-key wl-template-mode-map (kbd "<right>") 'wl-template-next)
(define-key wl-template-mode-map (kbd "<left>") 'wl-template-prev)

;;Only save draft when I tell it to! (C-x C-s or C-c C-s):
;;(arg: seconds of idle time untill auto-save).
;(setq wl-auto-save-drafts-interval nil)

(defun ck-wl-setup ()
  (mime-edit-set-sign t)
  (save-excursion
    (end-of-buffer)
    (insert-string "\n-- \n")
    (if (string-match "Termitel" wl-draft-parent-folder)
        (insert-file "~/dev/mail/signature-termitel")
      (insert-file "~/dev/mail/signature-defunct"))
    ))

(remove-hook 'wl-mail-setup-hook 'ck-wl-setup)
(add-hook 'wl-mail-setup-hook 'ck-wl-setup)

;; (defun get-string-from-file (filePath)
;;   "Return filePath's file content."
;;   (with-temp-buffer
;;     (insert-file-contents filePath)
;;     (buffer-string)))

(defun ck-refile-to-archive ()
  "Refile current message to archive folder"
  (interactive)

  (let ((msg-num (wl-summary-message-number))
        (entity)
        (msg-date)
        (folder))
    (setq entity (elmo-message-entity wl-summary-buffer-elmo-folder msg-num))
    (setq msg-date (elmo-message-entity-field entity 'date))
    (setq msg-date (format-time-string "%Y" msg-date))

    (if (string-match "Termitel" (wl-summary-buffer-folder-name))
        (setq folder (concat ".Termitel/Archiv." msg-date))
      (setq folder (concat ".Defunct/Archiv." msg-date)))
    (wl-summary-refile (wl-summary-message-number) folder)
    (wl-summary-next)
    (message "Refiled to %s" folder)))

(define-key wl-summary-mode-map (kbd "C-a") 'ck-refile-to-archive) ;; archive


;; eof
