(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'org)
(require 'ob-tangle)

(org-babel-load-file (expand-file-name "~/.emacs.d/emacs.org"))

