(defun tomku-org-init ()
  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)
  (global-set-key "\C-cc" 'org-capture)
  (setq org-directory (expand-file-name "~/Dropbox/notes/"))
  (setq org-default-notes-file (concat org-directory "notes.org"))
  (setq org-agenda-files (list org-directory)))

(tomku-org-init)
(provide 'tomku-org)
