(autoload 'magit-status "magit" nil t)

(when (featurep 'ns)
  (setq magit-emacsclient-executable "/usr/local/bin/emacsclient")
  )

;; eof
