(defun tomku-haskell-keys ()
  (local-set-key (kbd "C-c C-l") 'inferior-haskell-load-file)
  (local-set-key (kbd "C-c l") 'inferior-haskell-load-and-run))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'tomku-haskell-keys)

(provide 'tomku-haskell)
