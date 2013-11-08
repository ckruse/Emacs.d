; -*- coding: utf-8 -*-

(setq exec-path (append exec-path '("/usr/local/bin")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mumamo-background-chunk-major ((t nil)))
 '(mumamo-background-chunk-submode1 ((t nil)))
 )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((encoding . utf-8))))
)

(if (featurep 'ns)
    (setq browse-url-browser-function 'browse-url-generic
          browse-url-generic-program "open")
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "chromium")
  )


(setq x-select-enable-clipboard t)
(delete-selection-mode t)

; remove ugly and sucking toolbar
(tool-bar-mode 0)
(menu-bar-mode 0)

; show time in status line
(display-time)

;; show matching marens
(show-paren-mode 1)

;; show column and line numbers
(line-number-mode t)
(column-number-mode t)

;; show and remove trailing whitespaces
(setq-default show-trailing-whitespace t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq tab-width 2)
(setq-default tab-width 2)
(setq indent-tabs-mode nil)
(setq-default indent-tabs-mode nil)

(iswitchb-mode 1)

;disable backup
(setq backup-inhibited t)
(setq-default backup-inhibited t)
;disable auto save
(setq auto-save-default nil)
(setq-default auto-save-default nil)
(setq auto-save-list-file-prefix nil)
(setq-default auto-save-list-file-prefix nil)

(cond (
       (fboundp 'global-font-lock-mode)
       ;; Turn on font-lock in all modes that support it
       (global-font-lock-mode t)
       ;; Maximum colors
       (setq font-lock-maximum-decoration t)
       )
      )


; we wanna use utf8 normally
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)

; show trailing whitespaces
(setq show-trailing-whitespace t)
(setq-default whitespace-style '(face trailing newline empty newline-mark))

;; fuck off the splash screen
(setq inhibit-splash-screen t)

(setq dabbrev-case-fold-search t)


(add-to-list 'auto-mode-alist '("mutt-" . mail-mode))

(setq ring-bell-function 'ignore)

(defun passwords ()
  (interactive)
  (find-file "~/BTSync/org/passwords.org.gpg")
  )

(defalias 'yes-or-no-p 'y-or-n-p)
(setq confirm-kill-emacs 'y-or-n-p)

(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(defun align-repeat-after (start end regexp)
  "Repeat alignment with respect to
   the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat "\\(\\s-*\\)" regexp) 1 1 t
                )
  )

(defun align-repeat (start end regexp)
  "Repeat alignment with respect to
   the given regular expression."
  (interactive "r\nsAlign regexp: ")
  (align-regexp start end
                (concat regexp "\\(\\s-*\\)") 1 1 t
                )
  )


(toggle-scroll-bar -1)


(if (featurep 'ns)
    (set-default-font "Source Code Pro-11")
  (set-default-font "Source Code Pro-09")
  )

(defun djcb-find-file-as-root ()
  "Like `ido-find-file, but automatically edit the file with
root-privileges (using tramp/sudo), if the file is not writable by
user."
  (interactive)
  (let ((file (ido-read-file-name "Edit as root: ")))
    (unless (file-writable-p file)
      (setq file (concat "/sudo:root@localhost:" file)))
    (find-file file)))


(defun gtd ()
  (interactive)
  (find-file "~/BTSync/org/inbox.org")
  )


(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))



(defun goto-match-paren (arg)
  "Go to the matching  if on (){}[], similar to vi style of % "
  (interactive "p")
  ;; first, check for "outside of bracket" positions expected by forward-sexp, etc
  (cond ((looking-at "[\[\(\{]") (forward-sexp))
        ((looking-back "[\]\)\}]" 1) (backward-sexp))
        ;; now, try to succeed from inside of a bracket
        ((looking-at "[\]\)\}]") (forward-char) (backward-sexp))
        ((looking-back "[\[\(\{]" 1) (backward-char) (forward-sexp))
        (t nil)
        )
  )

(defun goto-matching-ruby-block (arg)
  (cond
   ((equal (current-word) "end")
    (ruby-beginning-of-block))

   ((string-match (current-word) "\\(for\\|while\\|until\\|if\\|class\\|module\\|case\\|unless\\|def\\|begin\\|do\\)")
    (ruby-end-of-block)
    )
   )
  )

(defun dispatch-goto-matching (arg)
  (interactive "p")

  (if (or
       (looking-at "[\[\(\{]")
       (looking-at "[\]\)\}]")
       (looking-back "[\[\(\{]" 1)
       (looking-back "[\]\)\}]" 1))
      (goto-match-paren arg)

    (when (eq major-mode 'ruby-mode)
      (goto-matching-ruby-block arg)
      )

    )
  )


;; (setq ssl-program-name "gnutls-cli"
;;       ssl-program-arguments '("--insecure" "-p" service host)
;;       ssl-certificate-verification-policy 1)

(setq ssl-program-name "openssl s_client -ssl2 -connect %s:%p")
(setq-default ssl-program-name "openssl s_client -ssl2 -connect %s:%p")

(defun region-to-hexcol ()
  (interactive)
  (let
      ((start (region-beginning))
       (end (region-end))
       (text))

    (setq text (buffer-substring-no-properties start end))

    (when (string-match "^[[:digit:]]+$" text)
      (setq text (format "%02x" (string-to-number text)))
      (delete-region start end)
      (insert text))))

(defun rgb-to-hex ()
  (interactive)

  (let
      ((start (region-beginning))
       (end (region-end)))

    (goto-char start)
    (set-mark start)
    (skip-chars-forward "0-9")
    (region-to-hexcol)

    (skip-chars-forward ", ")
    (set-mark (point))
    (skip-chars-forward "0-9")
    (region-to-hexcol)

    (skip-chars-forward ", ")
    (set-mark (point))
    (skip-chars-forward "0-9")
    (region-to-hexcol)

    (setq end (point))
    (goto-char start)

    (save-restriction
      (narrow-to-region start end)
      (while (re-search-forward "[, ]" nil t) (replace-match "" nil t)))))



(require 'gist)


(defun build-ctags ()
  (interactive)
  (message "building project tags")
  (let ((root (eproject-root))
    (if (string-match "/ios/" root)
        (shell-command (concat "find " root " -name '*.[hm]' | xargs /usr/local/bin/etags"))
      (shell-command (concat "/usr/local/bin/ctags -e -R --extra=+fq --exclude=db --exclude=test --exclude=.git --exclude=public -f " root "/TAGS " root))))
  (visit-project-tags)
  (message "tags built successfully"))

(defun visit-project-tags ()
  (interactive)
  (let ((tags-file (concat (eproject-root) "/TAGS")))
    (visit-tags-table tags-file)
    (message (concat "Loaded " tags-file))))


(defun kill-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(global-set-key (kbd "C-x K") 'kill-all-buffers)

(require 'dired-x)


;; scrolling

(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1
      mouse-wheel-follow-mouse 't
      mouse-wheel-scroll-amount '(1 ((shift) . 1)))


;; eof
