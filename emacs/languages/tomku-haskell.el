(defun tomku-haskell-keys ()
  (local-set-key (kbd "C-c C-l") 'inferior-haskell-load-file)
  (local-set-key (kbd "C-c l") 'inferior-haskell-load-and-run))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'tomku-haskell-keys)

(if (executable-find "agda-mode")
    (load-file (let ((coding-system-for-read 'utf-8))
                 (shell-command-to-string "agda-mode locate")))
   (if nix-platform
       (setq (agda2-include-dirs (quote ("." "/opt/agda/stdlib/src"))))
     (setq (agda2-include-dirs (quote ("." "C:/Tools/agda/stdlib/src"))))))


(provide 'tomku-haskell)
