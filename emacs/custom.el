;; I suppose I should leave this here, Emacs gets angry when I don't...
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(abbrev-file-name (concat shared-config-dir "abbrev_defs"))
 '(abbrev-mode nil t)
 '(agda2-include-dirs
   (quote
    ("." "/opt/agda/stdlib/src" "C:/Tools/agda/stdlib/src")))
 '(ansi-color-names-vector
   ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(auto-compression-mode t)
 '(auto-image-file-mode t)
 '(backup-directory-alist (list (cons "." (concat local-config-dir "backups"))))
 '(bookmark-default-file (concat local-config-dir "emacs.bmk"))
 '(c-basic-offset 4)
 '(c-default-style
   (quote
    ((c-mode . "bsd")
     (c++-mode . "bsd")
     (java-mode . "java")
     (awk-mode . "awk")
     (other . "bsd"))))
 '(case-fold-search t)
 '(clean-buffer-list-kill-never-regexps (quote ("^ \\*Minibuf-.*\\*$" "\\.org$")))
 '(coffee-tab-width 2)
 '(column-number-mode t)
 '(comint-scroll-to-bottom-on-input (quote this))
 '(compilation-error-screen-columns t)
 '(compilation-message-face (quote default))
 '(compilation-scroll-output nil)
 '(compilation-window-height nil)
 '(compile-auto-highlight nil)
 '(compile-command "make")
 '(cperl-electric-parens t)
 '(cperl-extra-perl-args "-w")
 '(cperl-font-lock t)
 '(cperl-hairy t)
 '(cperl-indent-level 4)
 '(cperl-invalid-face (quote none))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(current-language-environment "English")
 '(custom-safe-themes
   (quote
    ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "3b819bba57a676edf6e4881bd38c777f96d1aa3b3b5bc21d8266fa5b0d0f1ebf" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29" default)))
 '(display-time-mode t)
 '(echo-keystrokes 0.1)
 '(ede-project-placeholder-cache-file (concat local-config-dir "projects.ede"))
 '(ediff-window-setup-function (quote ediff-setup-windows-plain))
 '(eshell-directory-name (concat local-config-dir ".eshell/"))
 '(fci-rule-color "#eee8d5")
 '(ffap-file-finder (quote find-file))
 '(flyspell-abbrev-p t)
 '(flyspell-use-global-abbrev-table-p t)
 '(flyspell-use-meta-tab nil)
 '(global-font-lock-mode t)
 '(gnus-select-method (quote (nntp "news.gmane.org")))
 '(haskell-mode-hook
   (quote
    (turn-on-haskell-indent turn-on-haskell-indentation turn-on-haskell-doc-mode turn-on-haskell-decl-scan)) t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote cabal-repl))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#fdf6e3" 0.25)
    (quote
     ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
   (quote
    (("#eee8d5" . 0)
     ("#B4C342" . 20)
     ("#69CABF" . 30)
     ("#69B7F0" . 50)
     ("#DEB542" . 60)
     ("#F2804F" . 70)
     ("#F771AC" . 85)
     ("#eee8d5" . 100))))
 '(ido-create-new-buffer (quote always))
 '(ido-enable-dot-prefix t)
 '(ido-enable-flex-matching t)
 '(ido-enable-last-directory-history nil)
 '(ido-enabled (quote (quote both)) t)
 '(ido-everywhere t)
 '(ido-max-dir-file-cache 0)
 '(ido-mode (quote both) nil (ido))
 '(ido-save-directory-list-file (concat local-config-dir "ido.last"))
 '(ido-show-dot-for-dired t)
 '(ido-use-filename-at-point (quote guess))
 '(ido-use-url-at-point t)
 '(indent-tabs-mode nil)
 '(inhibit-eol-conversion nil)
 '(inhibit-startup-screen t)
 '(jit-lock-stealth-time 1)
 '(kill-whole-line t)
 '(line-number-mode t)
 '(magit-diff-use-overlays nil)
 '(menu-bar-mode nil)
 '(nxhtml-skip-welcome t)
 '(nxml-attribute-indent 2)
 '(nxml-child-indent 4)
 '(nxml-outline-child-indent 4)
 '(nxml-slash-auto-complete-flag t)
 '(org-catch-invisible-edits (quote smart))
 '(org-checkbox-hierarchical-statistics nil)
 '(org-hierarchical-checkbox-statistics nil)
 '(org-hierarchical-todo-statistics nil)
 '(org-refile-targets (quote ((org-agenda-files :maxlevel . 3))))
 '(org-refile-use-outline-path (quote file))
 '(pc-selection-mode t)
 '(preview-gs-options
   (quote
    ("-q" "-dNOPAUSE" "-DNOPLATFONTS" "-dPrinted" "-dTextAlphaBits=4" "-dGraphicsAlphaBits=4")))
 '(python-command "python")
 '(python-python-command "python")
 '(quack-programs
   (quote
    ("mzscheme" "bigloo" "csi" "csi -hygienic" "gosh" "gracket" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "racket" "racket -il typed/racket" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-smart-open-paren-p nil)
 '(recentf-save-file (concat local-config-dir ".recentf"))
 '(rng-schema-locating-files
   (quote
    ("schemas.xml" "/usr/share/emacs/23.1/etc/schema/schemas.xml" "/home/tom/.emacs.d/rnc/html5/html5-schemas.xml")))
 '(save-place t nil (saveplace))
 '(save-place-file (concat local-config-dir "emacs-places"))
 '(scroll-bar-mode (quote right))
 '(scroll-conservatively 400)
 '(scroll-margin 3)
 '(semanticdb-default-save-directory (concat local-config-dir "cache/semanticdb") t)
 '(size-indication-mode t)
 '(slime-repl-history-file (concat local-config-dir "history/slime-history.eld"))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(smex-save-file (concat local-config-dir "smex.save"))
 '(srecode-map-save-file (concat local-config-dir "cache/srecode/srecode-map"))
 '(tab-width 2)
 '(temp-buffer-max-height (lambda (buffer) (/ (- (frame-height) 2) 3)))
 '(temp-buffer-resize-mode t nil (help))
 '(temporary-file-directory (concat local-config-dir "temp"))
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(truncate-partial-width-windows nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#c37300")
     (60 . "#b97d00")
     (80 . "#b58900")
     (100 . "#a18700")
     (120 . "#9b8700")
     (140 . "#948700")
     (160 . "#8d8700")
     (180 . "#859900")
     (200 . "#5a942c")
     (220 . "#439b43")
     (240 . "#2da159")
     (260 . "#16a870")
     (280 . "#2aa198")
     (300 . "#009fa7")
     (320 . "#0097b7")
     (340 . "#008fc7")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(visible-bell nil)
 '(weechat-color-list
   (quote
    (unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496")))
 '(whitespace-line-column 100)
 '(whitespace-style
   (quote
    (trailing lines space-before-tab indentation space-after-tab))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "outline" :family "DejaVu Sans Mono for Powerline"))))
 '(highlight ((t (:underline t))))
 '(idle-highlight ((t (:foreground "dim gray")))))

