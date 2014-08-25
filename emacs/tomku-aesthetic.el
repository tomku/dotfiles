(tool-bar-mode -1)                      ; Hide toolbar
(set-scroll-bar-mode 'right)            ; Scrollbar on right

(setq inhibit-startup-screen t)         ; Hide startup screen

;; Solarized looks great in GUI, but terrible in the console.
(when window-system
    (load-theme 'solarized-dark t))

;; Change the default frame size so that it fits on my laptop's
;; screen.  This is not exactly optimal since it'll be small on other
;; PCs, but I'm too lazy to find a better way.
(add-to-list 'default-frame-alist '(height . 36))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(width . 120))

;; Show 'emacs : $filename' as the frame title, stolen from EmacsWiki
(setq frame-title-format 
      '(:eval 
        (concat "emacs : " (if buffer-file-name
                               (replace-regexp-in-string
                                "\\\\" "/"
                                (replace-regexp-in-string 
                                 (regexp-quote (getenv "HOME")) "~"
                                 (convert-standard-filename buffer-file-name)))
                             (buffer-name)))))


(provide 'tomku-aesthetic)
