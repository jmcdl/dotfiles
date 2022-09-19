;; Configure package.el to include MELPA.
(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

;; Ensure that use-package is installed.
;;
;; If use-package isn't already installed, it's extremely likely that this is a
;; fresh installation! So we'll want to update the package repository and
;; install use-package before loading the literate configuration.
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; This makes sure that =use-package= will install the package if it's not already
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Always compile packages, and use the newest version available.
  (use-package auto-compile
    :config (auto-compile-on-load-mode))
  (setq load-prefer-newer t)

;;; GENERAL SETTINGS

;; disable menu on startup
(menu-bar-mode -1)

;; disable tools on startup
(tool-bar-mode -1)

;; diable welcome screen
(setq inhibit-splash-screen t)

;; Set default font.
(set-face-attribute 'default nil
                    :family "Andale Mono"
                    :height 140
                    :weight 'normal
                    :width 'normal)

;; Set theme
(use-package nord-theme
    :defer t
    :init)
(load-theme 'nord t)

;; open files from home directoy
(setq default-directory "~/")

;; increase gc threshold
(setq gc-cons-threshold (* 20 (* 1024 1024)))

;; Call DELETE-TRAILING-WHITESPACE every time a buffer is saved.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Treat CamelCaseSubWords as separate words in every programming mode.
(add-hook 'prog-mode-hook 'subword-mode)

;; When opening a file, always follow symlinks.
(setq vc-follow-symlinks t)

;; ensure that files end with a new line
(setq require-final-newline t)

;; delete the selected text when typing over it
(delete-selection-mode t)

;; enable package for dragging lines and regions
(use-package move-text
  :config
  (move-text-default-bindings))

;; display line numbers
(global-display-line-numbers-mode t)

;; Store backups and auto-saved files in
;; TEMPORARY-FILE-DIRECTORY (which defaults to /tmp on Unix),
;; instead of in the same directory as the file. This means we're
;; still making backups, but not where they'll get in the way.

;; WARNING: on most Unix-like systems /tmp is volatile, in-memory
;; storage, so your backups won't survive if your computer crashes!
;; If you're not willing to take this risk, you shouldn't enable
;; this setting.
  (setq backup-directory-alist
        `((".*" . ,temporary-file-directory)))
  (setq auto-save-file-name-transforms
        `((".*" ,temporary-file-directory t)))

(setq read-process-output-max (* 1024 1024)) ;; 1mb
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

;; when scrolling outside of window only move one line at a time
(setq scroll-conservatively 100)


;; SENSIBLE DEFAULTS
(load "~/.emacs.d/sensible-defaults")
;; use-all-settings includes the following
(sensible-defaults/reset-text-size)
(sensible-defaults/open-files-from-home-directory)
(sensible-defaults/increase-gc-threshold)
(sensible-defaults/delete-trailing-whitespace)
(sensible-defaults/treat-camelcase-as-separate-words)
(sensible-defaults/automatically-follow-symlinks)
(sensible-defaults/make-scripts-executable)
(sensible-defaults/single-space-after-periods)
(sensible-defaults/offer-to-create-parent-directories-on-save)
;; (sensible-defaults/apply-changes-to-highlighted-region) - activated by default from emacs 23 on
(sensible-defaults/overwrite-selected-text)
(sensible-defaults/ensure-that-files-end-with-newline)
(sensible-defaults/confirm-closing-emacs)
(sensible-defaults/quiet-startup)
(sensible-defaults/make-dired-file-sizes-human-readable)
(sensible-defaults/shorten-yes-or-no)
(sensible-defaults/always-highlight-code)
(sensible-defaults/refresh-buffers-when-files-change)
(sensible-defaults/show-matching-parens)
(sensible-defaults/flash-screen-instead-of-ringing-bell)
(sensible-defaults/set-default-line-length-to 80)
(sensible-defaults/open-clicked-files-in-same-frame-on-mac)
(sensible-defaults/yank-to-point-on-mouse-click)
;; sensible key bindings
(sensible-defaults/use-all-keybindings)

;; enable Interactively-Do
;; (setq ido-enable-flex-matching t)
;; (setq ido-everywhere t)
;; (ido-mode 1)

;; Built-in project package
(require 'project)
(global-set-key (kbd "C-x p f") #'project-find-file)