;; -*- coding: utf-8 -*-

(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)


(when (featurep 'ns)
  (load "~/.emacs.d/emulate-mac-keyboard-mode")
  (emulate-mac-us-keyboard-mode))



