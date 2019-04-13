;; -*- coding: utf-8 -*-

(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; (tooltip-mode    -1)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa"        . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org"          . "https://orgmode.org/elpa/") t)

(package-initialize)

(setq site-lisp-dir
      (expand-file-name "site-lisp" user-emacs-directory))

(setq settings-dir
      (expand-file-name "settings" user-emacs-directory))

(add-to-list 'load-path settings-dir)
(add-to-list 'load-path site-lisp-dir)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(if (file-exists-p custom-file)
  (load custom-file))

;; use-package is the absolute basic of our configuration
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

(use-package defuns)
(use-package appearance)
(use-package basics)
(use-package dired-config)
(use-package init-shell)
(use-package personal)
(use-package packages)
(use-package languages)
(use-package init-web)
(use-package keybindings)
(use-package ck-org)
(use-package ibuffer-config)
(use-package hide-minors)
