;; -*- coding: utf-8 -*-

;; c files

(c-add-style "postgresql"
             '("bsd"
               (c-auto-align-backslashes . nil)
               (c-basic-offset . 4)
               (c-offsets-alist . ((case-label . +)
                                   (label . -)
                                   (statement-case-open . +)))
               (fill-column . 78) 
               (indent-tabs-mode . t)
               (tab-width . 4)))

(add-hook 'c-mode-hook
          (defun postgresql-c-mode-hook ()
            (when (string-match "/postgres\\(ql\\)?/" buffer-file-name)
              (c-set-style "postgresql"))))

;; perl files

(defun pgsql-perl-style ()
  "Perl style adjusted for PostgreSQL project"
  (interactive)
  (setq perl-brace-imaginary-offset 0)
  (setq perl-brace-offset 0)
  (setq perl-continued-brace-offset 4)
  (setq perl-continued-statement-offset 4)
  (setq perl-indent-level 4)
  (setq perl-label-offset -2)
  (setq tab-width 4))

(add-hook 'perl-mode-hook
          (defun postgresql-perl-mode-hook ()
             (when (string-match "/postgres\\(ql\\)?/" buffer-file-name)
               (pgsql-perl-style))))

;; doc files

(add-hook 'sgml-mode-hook
          (defun postgresql-sgml-mode-hook ()
             (when (string-match "/postgres\\(ql\\)?/" buffer-file-name)
               (setq fill-column 78)
               (setq indent-tabs-mode nil)
               (setq sgml-basic-offset 1))))


;;; Makefiles

;; use GNU make mode instead of plain make mode
(add-to-list 'auto-mode-alist '("/postgres\\(ql\\)?/.*Makefile.*" . makefile-gmake-mode))
(add-to-list 'auto-mode-alist '("/postgres\\(ql\\)?/.*\\.mk\\'" . makefile-gmake-mode))


;; eof
