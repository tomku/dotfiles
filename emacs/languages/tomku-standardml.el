;(add-to-list 'load-path (concat repo-dir "sml-mode/"))

(require 'sml-mode)
;(require 'sml-proc)

(add-to-list 'auto-mode-alist '("\\.\\(sml\\|sig\\)\\'" . sml-mode))

(provide 'tomku-standardml)
