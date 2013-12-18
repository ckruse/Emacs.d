;; -*- coding: utf-8 -*-

(require 'projectile)
(projectile-global-mode)

(setq projectile-indexing-method 'find
      projectile-enable-caching t)

(setq ffip-project-root-function 'projectile-project-root)
(setq-default ffip-project-root-function 'projectile-project-root)

(global-set-key "\C-p" 'projectile-find-file)

;; eof
