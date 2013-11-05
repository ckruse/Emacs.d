(defun pgsql-c-mode ()
  ;; sets up formatting for PostgreSQL C code
  (interactive)
  (c-mode)
  (setq tab-width 4)
  (c-set-style "bsd")             ; set c-basic-offset to 4, plus other stuff
  (setq c-basic-offset 4)
  (c-set-offset 'case-label '+)   ; tweak case indent to match PG custom
  (c-set-offset 'statement-case-open '+)   ; tweak case indent to match PG custom
  (setq indent-tabs-mode t)      ; make sure we keep tabs when indenting
  )

(push '("\\(postgres\\|pgsql\\).*\\.[chyl]\\'" . pgsql-c-mode)  auto-mode-alist)

;; eof
