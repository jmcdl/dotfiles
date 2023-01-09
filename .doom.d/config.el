;;; ~/.config/doom / config.el -* - lexical - binding: t; -* -

(setq user-full-name "James McDonell"
      user-mail-address "contact@jmcdl.com")

;; When I bring up Doom's scratch buffer with SPC x, it's often to play with
;; elisp or note something down(that isn't worth an entry in my notes). I can
;; do both in `lisp-interaction-mode'.
(setq doom-scratch-initial-major-mode 'lisp-interaction-mode)


;;
;;; UI

(setq doom-theme 'doom-dracula
     doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'light)
     doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13))

;; Line numbers are pretty slow all around. The performance boost of disabling
;; them outweighs the utility of always keeping them on.
(setq display-line-numbers-type nil)

;; Prevents some cases of Emacs flickering.
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;;; Modules

;;; :completion company
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(after! company
  (setq company-idle-delay nil))


;;; :ui modeline
;; An evil mode indicator is redundant with cursor shape
(advice-add #'doom-modeline-segment--modals :override #'ignore)


;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Implicit /g flag on evil ex substitution, because I use the default behavior
;; less often.
(setq evil-ex-substitute-global t)


;;; :tools lsp
;; Disable invasive lsp-mode features
(after! lsp-mode
  (setq lsp-enable-symbol-highlighting nil
        ;; If an LSP server isn't present when I start a prog-mode buffer, you
        ;; don't need to tell me. I know. On some machines I don't care to have
        ;; a whole development environment for some ecosystems.
        lsp-enable-suggest-server-download nil))
(after! lsp-ui
  (setq lsp-ui-sideline-enable nil  ; no more useful than flycheck
        lsp-ui-doc-enable nil))     ; redundant with K


;;; :tools magit
;; (setq magit-repository-directories '(("~/projects" . 2))
;;       magit-save-repository-buffers nil
;;       ;; Don't restore the wconf after quitting magit, it's jarring
;;       magit-inhibit-save-previous-winconf t
;;       transient-values '((magit-rebase "--autosquash" "--autostash")
;;                          (magit-pull "--rebase" "--autostash")
;;                          (magit-revert "--autostash")))


;;; :lang org
(setq +org-roam-auto-backlinks-buffer t
      org-directory "~/org/"
      org-roam-directory "~/org/roam/"
      org-roam-db-location (concat org-roam-directory ".org-roam.db")
      org-roam-dailies-directory "journal/"
      org-agenda-files (directory-files-recursively org-directory "\\.org$")
      org-archive-location (concat org-directory ".archive/%s::"))

(after! org
;;; org-agenda configs
  (setq
    org-default-notes-file (concat org-directory "refile.org")
        org-refile-targets (quote ((nil :maxlevel . 3)
                            (org-agenda-files :maxlevel . 3)))
        org-enforce-todo-dependencies t
        org-agenda-skip-scheduled-if-done t
        org-agenda-skip-deadline-if-done t
        org-agenda-include-deadlines t)

  (setq org-startup-folded 'show2levels
        org-ellipsis " [...] "
        org-hide-emphasis-markers t
        org-todo-keywords
        (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
                (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)")))
        ;; My org/org-roam capture templates
        org-capture-templates
        '(("t" "Todo" entry (file "refile.org")
          "* TODO %?\n  %i\n")
          ("n" "Note" entry (file "refile.org")
          "* %?\n")
          ("j" "Journal" entry (file+datetree "journal.org")
          "* %?\n"))))

  (remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
