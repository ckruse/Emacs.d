;; -*- coding: utf-8 -*-

(require 'erc-hl-nicks)
(add-to-list 'erc-modules 'hl-nicks)

(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "477"))

;; don't show any of this
;(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))
(setq erc-track-exclude-server-buffer t
      erc-fill-column 160
      erc-max-buffer-size 30000
      erc-truncate-buffer-on-save t

      erc-timestamp-only-if-changed-flag nil
      erc-timestamp-format "[%H:%M] "
      erc-fill-prefix      "       + "
      erc-insert-timestamp-function 'erc-insert-timestamp-left)

(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook 'erc-truncate-buffer)

(setq erc-format-query-as-channel-p t
      ;;erc-track-priority-faces-only 'all
      erc-track-faces-priority-list '(erc-error-face
                                      erc-current-nick-face
                                      erc-keyword-face
                                      erc-nick-msg-face
                                      erc-direct-msg-face
                                      erc-dangerous-host-face
                                      erc-notice-face
                                      erc-prompt-face))

(defun ck/erc-md ()
  "Minimal distraction for all channels except #emacs"
  (interactive)
  (setq erc-track-priority-faces-only
        (remove "#warpzone" (remove "#ccc" (remove "#selfhtml" (ck/erc-joined-channels))))))

(defun ck/erc-joined-channels ()
  "Return all the channels you're in as a list.  This does not include queries."
  (save-excursion
    ;; need to get out of ERC mode so we can have *all* channels returned
    (set-buffer "*scratch*")
    (mapcar #'(lambda (chanbuf)
                (with-current-buffer chanbuf (erc-default-target)))
            (erc-channel-list erc-process))))

(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defadvice erc-track-find-face (around erc-track-find-face-promote-query activate)
  (if (erc-query-buffer-p)
      (setq ad-return-value (intern "erc-current-nick-face"))
    ad-do-it))

(defun ck/erc-track-switch-buffer ()
  (interactive)
  (if (eq major-mode 'erc-mode)
      (erc-track-switch-buffer 1)
    (when (erc-track-get-active-buffer 1)
      (erc-track-switch-buffer 1))))

;; eof
