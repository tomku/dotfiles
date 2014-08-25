(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)

(add-to-list 'auto-mode-alist '("\\.pl$" . prolog-mode))
(add-to-list 'auto-mode-alist '("\\.m$" . mercury-mode))

; @begin(62153991)@ - Do not edit these lines - added automatically!
(if (file-exists-p "/home/tom/.local/opt/ciao/lib/ciao/ciao-1.14/ciao-mode-init.el")
(load-file "/home/tom/.local/opt/ciao/lib/ciao/ciao-1.14/ciao-mode-init.el")
)
; @end(62153991)@ - End of automatically added lines.
(provide 'tomku-prolog)

