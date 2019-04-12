(use-package ibuffer
  :ensure nil
  :defines all-the-icons-icon-alist
  :functions (all-the-icons-icon-for-file
              all-the-icons-icon-for-mode
              all-the-icons-match-to-alist
              all-the-icons-faicon)
  :commands (ibuffer-current-buffer
             ibuffer-find-file
             ibuffer-do-sort-by-alphabetic)
  :bind ("C-x C-b" . ibuffer)
  :init
  (setq ibuffer-filter-group-name-face '(:inherit (font-lock-string-face bold)))

  ;; Display buffer icons on GUI
  (when (display-graphic-p)
    (define-ibuffer-column icon (:name " ")
      (let ((icon (if (and buffer-file-name
                           (all-the-icons-match-to-alist buffer-file-name
                                                         all-the-icons-icon-alist))
                      (all-the-icons-icon-for-file (file-name-nondirectory buffer-file-name)
                                                   :height 0.9 :v-adjust -0.05)
                    (all-the-icons-icon-for-mode major-mode :height 0.9 :v-adjust -0.05))))
        (if (symbolp icon)
            (setq icon (all-the-icons-faicon "file-o" :face 'all-the-icons-dsilver :height 0.9 :v-adjust -0.05))
          icon)))

    (setq ibuffer-formats '((mark modified read-only locked
                                  " " (icon 2 2 :left :elide) (name 18 18 :left :elide)
                                  " " (size 9 -1 :right)
                                  " " (mode 16 16 :left :elide) " " filename-and-process)
                            (mark " " (name 16 -1) " " filename))))

  :config
  ;; Group ibuffer's list by project root
  (use-package ibuffer-projectile
    :ensure t
    :functions all-the-icons-octicon
    :hook ((ibuffer . (lambda ()
                        (ibuffer-projectile-set-filter-groups)
                        (unless (eq ibuffer-sorting-mode 'alphabetic)
                          (ibuffer-do-sort-by-alphabetic)))))
    :config
    (setq ibuffer-projectile-prefix
          (if (display-graphic-p)
              (concat
               (all-the-icons-octicon "file-directory"
                                      :face ibuffer-filter-group-name-face
                                      :v-adjust -0.1
                                      :height 1.1)
               " ")
            "Project: "))))

(provide 'ibuffer-config)
