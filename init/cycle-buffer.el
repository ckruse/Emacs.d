;; -*- coding: utf-8 -*-

(autoload 'cycle-buffer "cycle-buffer" "Cycle forward." t)
(autoload 'cycle-buffer-backward "cycle-buffer" "Cycle backward." t)
(autoload 'cycle-buffer-permissive "cycle-buffer" "Cycle forward allowing *buffers*." t)
(autoload 'cycle-buffer-backward-permissive "cycle-buffer" "Cycle backward allowing *buffers*." t)
(autoload 'cycle-buffer-toggle-interesting "cycle-buffer" "Toggle if this buffer will be considered." t)

(global-set-key [M-s-right] 'cycle-buffer)
(global-set-key [M-s-left] 'cycle-buffer-backward)
(global-set-key [C-S-s-right] 'cycle-buffer-permissive)
(global-set-key [C-S-s-left] 'cycle-buffer-backward-permissive)

;; eof
