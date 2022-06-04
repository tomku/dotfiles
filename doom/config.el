;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name (getenv "ME")
      user-mail-address (getenv "EMAIL"))

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
(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 13 :weight 'normal))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

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

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-hook 'window-setup-hook 'toggle-frame-fullscreen)

(setq scroll-margin 10)

(setq projectile-project-search-path '("~/proj/"))

(add-hook 'doom-switch-frame-hook #'do-auto-save)

;; mu4e
(after! mu4e
  (setq mu4e-get-mail-command "mbsync -a")

  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)

  (setq mu4e-view-html-plaintext-ratio-heuristic most-positive-fixnum)

  (setq mu4e-headers-fields '((:account-stripe . 1)
                              (:human-date . 19)
                              (:flags . 6)
                              (:from-or-to . 25)
                              (:subject)))

  (setq mu4e-date-format-long "%F"
        mu4e-headers-date-format "%F %T"
        mu4e-update-interval 600
        mu4e-view-date-format "%F")

  (add-to-list 'mm-discouraged-alternatives "text/html")
  (add-to-list 'mm-discouraged-alternatives "text/richtext")

  (set-email-account! "fastmail"
                      `((mu4e-sent-folder . "/fastmail/Sent")
                        (mu4e-drafts-folder . "/fastmail/Drafts")
                        (mu4e-trash-folder . "/fastmail/Trash")
                        (mu4e-refile-folder . "/fastmail/Archive")
                        (smtpmail-smtp-user . ,user-mail-address)
                        (user-mail-address . ,user-mail-address)
                        (user-full-name . ,user-full-name))
                      t))

;; WebAssembly
(use-package! wat-mode)

;; Prolog
(use-package! ediprolog
  :init
  (global-set-key "\C-c\C-e" 'ediprolog-dwim))

(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . perl-mode)
                                ("\\.m$" . mercury-mode))
                              auto-mode-alist))

;; vertico
(after! vertico
  (setq vertico-sort-function #'vertico-sort-history-alpha))

;; deft
(after! deft
  (setq deft-directory "~/Sync/org"
        deft-extensions '("org" "txt")
        deft-recursive t))

;; org-mode
(setq org-journal-date-format "%F, %A"
      org-journal-file-format "%F.org")

(when (file-directory-p "~/Sync/roam")
  (setq org-roam-directory "~/Sync/roam")
  (after! org-roam
    (org-roam-db-autosync-mode)))

(map! :localleader
      :mode 'org
      :map 'org-mode-map
      :desc "org-lint"
      "!" #'org-lint)

(map! :leader
      :desc "Open a URL in eww"
      "o w" #'eww)

(map! :leader
      :desc "Open the Emacs calculator"
      "o c" #'calc)

(after! sokoban
  (define-key sokoban-mode-map (kbd "j") 'sokoban-move-down)
  (define-key sokoban-mode-map (kbd "k") 'sokoban-move-up)
  (define-key sokoban-mode-map (kbd "h") 'sokoban-move-left)
  (define-key sokoban-mode-map (kbd "l") 'sokoban-move-right)
  (define-key sokoban-mode-map (kbd "L") 'sokoban-load)
  (setq evil-escape-excluded-major-modes (append  '(sokoban-mode)
                              evil-escape-excluded-major-modes)))
