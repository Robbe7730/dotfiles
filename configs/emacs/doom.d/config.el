;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Robbe Van Herck"
      user-mail-address "robbe@robbevanherck.be")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(load! "+secrets")

(setq org-log-done t)

(setq org-agenda-files (list "~/.org"))

(setq org-agenda-span 'week)

(setq org-roam-directory (file-truename "~/.org/roam"))
(setq org-roam-dailies-directory "journals/")
(setq org-roam-capture-templates
   '(
        ("d" "default" plain "%?"
         :target (file+head "pages/${slug}.org" "#+TITLE: ${title}\n#+FILETAGS: :Notes:")
         :unnarrowed t)
    ))

(org-roam-db-autosync-mode)

(setq org-todo-keywords
      '((sequence "TODO(t)" "STRT(s)" "WAIT(w)" "|" "HOLD(h)" "DONE(d)" "KILL(k)"))
)

(setq org-comment-string "ARCHIVE")

(setq org-agenda-prefix-format '(
        (agenda . " %i %-12:c%?-12t% s")
        (timeline . "  % s")
        (todo . " %i %-12:c%l")
        (tags . " %i %-12:c")
        (search . " %i %-12:c")
))

(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

(setq lsp-rust-server 'rust-analyzer)
