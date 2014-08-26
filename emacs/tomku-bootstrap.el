(require 'package)

(unless (featurep 'package)
  (error "Upgrade Emacs to a version that includes package.el"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

;;; From http://stackoverflow.com/questions/10092322/how-to-automatically-install-emacs-packages-by-specifying-a-list-of-package-name
(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.
Return a list of installed packages or nil for every package not installed."
  (mapcar
   (lambda (package)
     (package-installed-p 'evil)
     (if (package-installed-p package)
         package
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         nil)))
   packages))

(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'auctex 'autopair 'browse-kill-ring
                          'frame-cmds 'frame-fns 'gh 'gist
                          'haskell-mode 'idris-mode
                          'idle-highlight-mode 'magit 'markdown-mode
                          'mouse+ 'org-plus-contrib 'paredit 'smex
                          'sml-mode 'solarized-theme 'textmate
                          'yasnippet 'yaml-mode 'zenburn-theme)

(provide 'tomku-bootstrap)
  
