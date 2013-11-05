;; -*- coding: utf-8 -*-

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t
      redisplay-dont-pause t
      ido-use-faces nil)

(require 'flx-ido)
(flx-ido-mode 1)

(require 'ido-vertical-mode)
(ido-vertical-mode)

(set-default 'imenu-auto-rescan t)

;; eof
