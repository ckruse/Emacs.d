;; -*- coding: utf-8 -*-

(defun ck/window-pixel-width ()
  (let ((coords (window-pixel-edges)))
        (- (nth 2 coords) (nth 0 coords))))

(defun ck/window-pixel-height ()
  (let ((coords (window-pixel-edges)))
        (- (nth 3 coords) (nth 1 coords))))


(defun ck/spawn-eshell ()
  (interactive)
  (message "w:%d, h:%d" (ck/window-pixel-width) (ck/window-pixel-height))
  (if (> (ck/window-pixel-height) (ck/window-pixel-width))
    (progn
      (split-window-vertically)
      (eshell))
    (progn
      (split-window-horizontally)
      (eshell))))

(global-set-key (kbd "C-x e") 'ck/spawn-eshell)

9;; eof
