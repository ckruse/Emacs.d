;; -*- coding: utf-8 -*-

(defun ck/is-osx ()
  (or (featurep 'ns)
      (featurep 'mac)))

(defun ck/kill-all-buffers ()
  (interactive)
  (mapcar 'kill-buffer (buffer-list))
  (delete-other-windows))

(defun ck/web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2
          web-mode-css-indent-offset 2
          web-mode-code-indent-offset 2
          web-mode-enable-auto-indentation nil))

(defun ck/define-projectile-filter-groups ()
  (when (boundp 'projectile-known-projects)
    (setq my/project-filter-groups
          (mapcar
           (lambda (it)
             (let ((name (file-name-nondirectory (directory-file-name it))))
               `(,name (filename . ,(expand-file-name it)))))
           projectile-known-projects))))


(defun set-GEM_PATH-from-shell-GEM_PATH ()
  (interactive)
  (let ((path-from-shell (replace-regexp-in-string "[ \t\n]*$" "" (shell-command-to-string "$SHELL --login -i -c 'echo $GEM_PATH'"))))
    (setenv "GEM_PATH" path-from-shell)))
(set-GEM_PATH-from-shell-GEM_PATH)


(defun ck-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun ck-put-file-name-wo-path-on-clipboard ()
  "Put the current file name on the clipboard"
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (setq filename (file-name-nondirectory filename))
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))

(defun ck/comment-line-or-region (n)
  "Comment or uncomment current line and leave point after it.
  With positive prefix, apply to N lines including current one.
  With negative prefix, apply to -N lines above.
  If region is active, apply to active region instead."
  (interactive "p")
  (if (use-region-p)
      (comment-or-uncomment-region
       (region-beginning) (region-end))
    (let ((range
           (list (line-beginning-position)
                 (goto-char (line-end-position n)))))
      (comment-or-uncomment-region
       (apply #'min range)
       (apply #'max range)))
    (forward-line 1)
    (back-to-indentation)))


(defun ck/xml-format ()
  "Format an XML buffer with `xmllint'."
  (interactive)
  (shell-command-on-region (point-min) (point-max)
                           "xmllint -format -"
                           (current-buffer) t
                           "*Xmllint Error Buffer*" t))


(defun ck/theme-dark ()
  (interactive)
  (load-theme 'spacemacs-dark t)
  (spaceline-emacs-theme))

(defun ck/theme-light ()
  (interactive)
  (load-theme 'spacemacs-light t)
  (spaceline-emacs-theme))

(defun erl-get-lib-path (path)
  (format "%s/%s/emacs" path (car (directory-files path nil "^tools"))))

(defun ck/org-tags ()
  (interactive)
  (get-buffer-create "*org-tags*")
  (set-buffer "*org-tags*")
  (org-mode)
  (let ((tags (sort (delete-dups (apply 'append (delete-dups (org-map-entries (lambda () org-scanner-tags) t 'agenda)))) 'string<)))
    (dolist (tag tags)
      (insert (concat "[[elisp:(org-tags-view nil \"" tag "\")][" tag  "]]\n"))))
  (beginning-of-buffer)
  (switch-to-buffer "*org-tags*"))


(provide 'defuns)
