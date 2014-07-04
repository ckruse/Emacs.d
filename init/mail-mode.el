;; -*- coding: utf-8 -*-

(add-to-list 'auto-mode-alist '("mutt-" . mail-mode))
(add-to-list 'auto-mode-alist '("kmail" . mail-mode))
(add-to-list 'auto-mode-alist '(".eml" . mail-mode))


(defface mail-double-quoted-text-face
  '((((class color)) :foreground "SteelBlue")) "Double-quoted email.")
(defface mail-treble-quoted-text-face
  '((((class color)) :foreground "SlateGrey")) "Treble-quoted email.")
(defface mail-multiply-quoted-text-face
  '((((class color)) :foreground "DarkSlateGrey")) "Multiply-quoted email.")

(font-lock-add-keywords 'mail-mode
                        '(("^\\(\\( *>\\)\\{4,\\}\\)\\(.*\\)$"
                           (1 'font-lock-comment-delimiter-face)
                           (3 'mail-multiply-quoted-text-face))
                          ("^\\(\\( *>\\)\\{3\\}\\)\\(.*\\)$"
                           (1 'font-lock-comment-delimiter-face)
                           (3 'mail-treble-quoted-text-face))
                          ("^\\( *> *>\\)\\(.*\\)$"
                           (1 'font-lock-comment-delimiter-face)
                           (2 'mail-double-quoted-text-face))))
;; eof
