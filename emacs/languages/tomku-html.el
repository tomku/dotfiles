(defun tomku-nxhtml-init ()
  (add-to-list 'flyspell-prog-text-faces 'nxml-text-face)
  (setq mumamo-chunk-coloring 'submode-colored
        nxhtml-skip-welcome t
        indent-region-mode t))

;(load (concat repo-dir "nxhtml/autostart.el"))
;(require 'nxhtml)
;(tomku-nxhtml-init)

(setq rng-schema-locating-files '())

;(add-to-list 'load-path (concat repo-dir "html5-el/"))
;(require 'whattf-dt)

;; (add-to-list 'rng-schema-locating-files
;;              (expand-file-name "~/code/html5-el/schemas.xml"))

(provide 'tomku-html)
