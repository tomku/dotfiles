(setq debug-on-error t)

(setq user-full-name "Thomas Kurth")
(setq user-email-address "tom@losthalo.org")

(setq home-dir (concat (expand-file-name (getenv "HOME")) "/"))

(setq shared-config-dir (file-name-directory
                         (or (buffer-file-name) load-file-name)))

(setq local-config-dir (concat home-dir ".emacs.d/"))

(add-to-list 'load-path shared-config-dir)

(setq nix-platform t)

(when (or (eq system-type 'ms-dos)
          (eq system-type 'windows-nt))
  (setq nix-platform nil))

(require 'tomku-bootstrap)
(require 'tomku-aesthetic)
(require 'tomku-general)
(require 'tomku-languages)
(require 'tomku-org)
(require 'tomku-prefs)
(require 'tomku-keys)

(setq custom-file (concat shared-config-dir "custom.el"))
(load custom-file 'noerror)

(cd home-dir)

(server-start)
