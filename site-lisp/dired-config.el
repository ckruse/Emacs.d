(use-package dired
  :ensure nil
  :config
  (setq dired-recursive-deletes 'always)
  (setq dired-recursive-copies 'always)

  (when (ck/is-osx)
    (setq dired-use-ls-dired nil)

    (use-package diredfl
      :ensure t
      :init (diredfl-global-mode 1))

    (use-package dired-x
      :ensure nil
      :demand
      :config
      (let ((cmd (cond
                  ((ck/is-osx) "open")
                  (t "xdg-open"))))
        (setq dired-guess-shell-alist-user
              `(("\\.pdf\\'" ,cmd)
                ("\\.docx\\'" ,cmd)
                ("\\.\\(?:djvu\\|eps\\)\\'" ,cmd)
                ("\\.\\(?:jpg\\|jpeg\\|png\\|gif\\|xpm\\)\\'" ,cmd)
                ("\\.\\(?:xcf\\)\\'" ,cmd)
                ("\\.csv\\'" ,cmd)
                ("\\.tex\\'" ,cmd)
                ("\\.\\(?:mp4\\|mkv\\|avi\\|flv\\|rm\\|rmvb\\|ogv\\)\\(?:\\.part\\)?\\'" ,cmd)
                ("\\.\\(?:mp3\\|flac\\)\\'" ,cmd)
                ("\\.html?\\'" ,cmd)
                ("\\.md\\'" ,cmd))))

      (setq dired-omit-files
            (concat dired-omit-files
                    "\\|^.DS_Store$\\|^.projectile$\\|^.git*\\|^.svn$\\|^.vscode$\\|\\.js\\.meta$\\|\\.meta$\\|\\.elc$\\|^.emacs.*"))))


  (use-package all-the-icons-dired
    :ensure t
    :diminish
    :custom-face (all-the-icons-dired-dir-face ((t (:foreground nil))))
    :hook (dired-mode . all-the-icons-dired-mode)
    :config
    (defun my-all-the-icons-dired--display ()
      "Display the icons of files without colors in a dired buffer."
      (when (and (not all-the-icons-dired-displayed) dired-subdir-alist)
        (setq-local all-the-icons-dired-displayed t)
        (let ((inhibit-read-only t)
              (remote-p (and (fboundp 'tramp-tramp-file-p)
                             (tramp-tramp-file-p default-directory))))
          (save-excursion
            (goto-char (point-min))
            (while (not (eobp))
              (when (dired-move-to-filename nil)
                (let ((file (dired-get-filename 'verbatim t)))
                  (unless (member file '("." ".."))
                    (let ((filename (dired-get-filename nil t)))
                      (if (file-directory-p filename)
                          (let* ((matcher (all-the-icons-match-to-alist file all-the-icons-dir-icon-alist))
                                 (icon (cond
                                        (remote-p
                                         (all-the-icons-octicon "file-directory" :height 0.93 :v-adjust all-the-icons-dired-v-adjust :face 'all-the-icons-dired-dir-face))
                                        ((file-symlink-p filename)
                                         (all-the-icons-octicon "file-symlink-directory" :height 0.93 :v-adjust all-the-icons-dired-v-adjust :face 'all-the-icons-dired-dir-face))
                                        ((all-the-icons-dir-is-submodule filename)
                                         (all-the-icons-octicon "file-submodule" :height 0.93 :v-adjust all-the-icons-dired-v-adjust :face 'all-the-icons-dired-dir-face))
                                        ((file-exists-p (format "%s/.git" filename))
                                         (all-the-icons-octicon "repo" :height 1.0 :v-adjust all-the-icons-dired-v-adjust :face 'all-the-icons-dired-dir-face))
                                        (t (apply (car matcher) (list (cadr matcher) :height 0.93 :face 'all-the-icons-dired-dir-face :v-adjust all-the-icons-dired-v-adjust))))))
                            (insert (concat icon " ")))
                        (insert (concat (all-the-icons-icon-for-file file :height 0.9 :v-adjust -0.05) " ")))))))
              (forward-line 1))))))
    (advice-add #'all-the-icons-dired--display :override #'my-all-the-icons-dired--display)))

(provide 'dired-config)
