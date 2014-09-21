;; -*- coding: utf-8 -*-

(require 'projectile)
(projectile-global-mode)

(setq projectile-indexing-method 'find
      projectile-enable-caching t)

(global-set-key "\C-p" 'projectile-find-file)


;; eof
