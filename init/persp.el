;; -*- coding: utf-8 -*-

;; Load Perspective
(require 'persp-mode)

;; Enable perspective mode
(persp-mode t)

;; TODO: implement persp-last as before-advice on persp-switch (?)

(defmacro custom-persp (name &rest body)
  `(let ((initialize (not (gethash ,name perspectives-hash)))
         (current-perspective persp-curr))
     (persp-switch ,name)
     (when initialize ,@body)
     (setq persp-last current-perspective)))

;; eof
