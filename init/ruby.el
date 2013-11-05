(autoload 'ruby-mode "ruby-mode" "Load ruby-mode")

(add-hook 'ruby-mode-hook 'turn-on-font-lock)
(add-hook 'ruby-mode-hook (lambda ()
                            (setq tab-width 2
                                  indent-tabs-mode nil
                                  ruby-deep-arglist nil
                                  ruby-deep-indent-paren nil
                                  ruby-insert-encoding-magic-comment nil
                                  )
                            )
          )

;(add-to-list 'load-path "~/.emacs.d/packages/hrb-mode/")
;(require 'hrb-mode)
;(setq hrb-delay 0)
;(setq hrb-highlight-mode 'mixed)
;(hrb-mode t)

;; (add-to-list 'auto-mode-alist '("\\.html\\.erb$" . eruby-nxhtml-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.rhtml$" . eruby-nxhtml-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.prawn$" . ruby-mode))

;; Interactively Do Things (highly recommended, but not strictly required)
;(require 'ido)
;(ido-mode t)

;; (add-to-list 'load-path "~/.emacs.d/packages/enhanced-ruby-mode/")

;; (if (featurep 'ns)
;;     (setq enh-ruby-program "/usr/local/bin/ruby")
;;   (setq enh-ruby-program "/usr/bin/ruby"))

;; (autoload 'enh-ruby-mode "enh-ruby-mode" "Major mode for ruby files" t)
;; (add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("Rakefile$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("\\.ru$" . enh-ruby-mode))
;; (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))

;; (add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))

;; (add-to-list 'load-path "~/.emacs.d/packages/hrb-mode/")
;; (require 'hrb-mode)
;; (setq hrb-delay 0)
;; (setq hrb-highlight-mode 'mixed)
;; (hrb-mode t)

;; eof
