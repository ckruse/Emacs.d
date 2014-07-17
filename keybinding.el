(global-set-key [home] 'smarter-move-beginning-of-line)
(global-set-key [s-left] 'smarter-move-beginning-of-line)
(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-line)
(global-set-key [C-end] 'end-of-buffer)

(global-set-key (kbd "C-#") 'undo)

(global-set-key "\M--" 'dispatch-goto-matching)


(defvar my-keys-minor-mode-map (make-keymap) "my-keys-minor-mode keymap.")
(define-key my-keys-minor-mode-map (kbd "M-<") 'pop-to-mark-command)
(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t " my-keys" 'my-keys-minor-mode-map)
(my-keys-minor-mode 1)
(defun my-minibuffer-setup-hook ()
  (my-keys-minor-mode 0)
  )
(add-hook 'minibuffer-setup-hook 'my-minibuffer-setup-hook)

(global-set-key (kbd "C--") 'dabbrev-expand)
(define-key minibuffer-local-map (kbd "C--") 'dabbrev-expand)


(global-set-key [f2] 'point-to-register)
(global-set-key [f3] 'jump-to-register)

(global-set-key [f7] 'bookmark-set)
(global-set-key [f8] 'bookmark-jump)

(global-set-key "\C-c\C-c" 'comment-region)
(global-set-key "\C-cc" 'uncomment-region)

(global-set-key (kbd "C-x C-a") 'magit-status)

(global-set-key (kbd "C-x F") 'djcb-find-file-as-root)

(global-set-key (kbd "s--") 'gtd)

(when (featurep 'ns)
  (global-set-key [kp-delete] 'delete-char))

(global-set-key (kbd "s-.") 'find-tag)

(global-set-key (kbd "C-c C-a") 'eshell)


(global-set-key [s-up] 'beginning-of-buffer)
(global-set-key [s-right] 'end-of-line)
(global-set-key [s-down] 'end-of-buffer)

(global-set-key "\C-a" 'mark-whole-buffer)

(global-set-key (kbd "s-}") 'pop-tag-mark)

(global-set-key (kbd "C-z") 'yank)

;; eof
