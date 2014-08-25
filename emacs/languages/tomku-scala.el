(setq scala-root-dir (getenv "SCALA_HOME"))
(setq scala-mode-dir (concat scala-root-dir "/misc/scala-tool-support/emacs"))

(setq ensime-dir (concat repo-dir "ensime/elisp/"))

(when (and scala-root-dir (file-exists-p scala-mode-dir))
  (add-to-list 'load-path scala-mode-dir)
  (require 'scala-mode-auto)
  (defun tomku-scala-mode-hook ()
    (local-set-key (kbd "RET") 'newline-and-indent))
  (add-hook 'scala-mode-hook 'tomku-scala-mode-hook)
  (when (file-exists-p ensime-dir)
    (add-to-list 'load-path ensime-dir)
    (require 'ensime)
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook))
  
  )

(provide 'tomku-scala)