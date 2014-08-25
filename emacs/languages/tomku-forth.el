(setq forth-root-dir (getenv "FORTH_HOME"))

(when (and forth-root-dir (file-exists-p forth-root-dir))
  (add-to-list 'load-path forth-root-dir)
  (autoload 'forth-mode "gforth.el" ""  t)
  (autoload 'forth-block-mode "gforth.el" ""  t)
  (add-to-list 'auto-mode-alist '("\\.fs$" . forth-mode))
  (add-to-list 'auto-mode-alist '("\\.f$" . forth-mode))
  
  
  (defun tomku-forth-mode-hook ()
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'forth-mode-hook 'tomku-forth-mode-hook))

(provide 'tomku-forth)