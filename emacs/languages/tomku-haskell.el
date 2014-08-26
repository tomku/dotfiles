(defun tomku-haskell-keys ()
  (local-set-key (kbd "C-c C-l") 'inferior-haskell-load-file)
  (local-set-key (kbd "C-c l") 'inferior-haskell-load-and-run))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'tomku-haskell-keys)

(if (executable-find "agda-mode")
    (load-file (let ((coding-system-for-read 'utf-8))
                 (shell-command-to-string "agda-mode locate"))))

(eval-after-load 'haskell-mode
            '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

(defun tomku-haskell-path (haskell-bin-path)
  (setenv "PATH" (concat haskell-bin-path ":" (getenv "PATH")))
  (add-to-list 'exec-path haskell-bin-path)
  (custom-set-variables '(haskell-tags-on-save t)))

(let ((haskell-bin-path "/opt/haskell-support/bin"))
  (if (file-exists-p haskell-bin-path)
      (tomku-haskell-path haskell-bin-path)))

(custom-set-variables
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t))
(eval-after-load 'haskell-mode
  '(progn
     (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
     (define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
     (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
     (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
     (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)
     (define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)))
(eval-after-load 'haskell-cabal
  '(progn
     (define-key haskell-cabal-mode-map (kbd "C-`") 'haskell-interactive-bring)
     (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-ode-clear)
     (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
     (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))

(custom-set-variables '(haskell-process-type 'cabal-repl))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(add-hook 'haskell-mode-hook 'company-mode)
(eval-after-load "company-ghc"
  '(progn
     (add-to-list 'company-backends 'company-ghc)
     (custom-set-variables '(company-ghc-show-info t))))

(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(provide 'tomku-haskell)
