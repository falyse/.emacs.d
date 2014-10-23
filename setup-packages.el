;; Time-stamp: <2014-01-17 17:33:43 cschmitt>

;; This file handles package management and automatic
;; loading of packages at startup from ELPA repositories

;; Define prepend and append path functions to be used to setup source directories
(defun prepend-path ( my-path )
  (setq load-path (cons (expand-file-name my-path) load-path)))
(defun append-path ( my-path )
  (setq load-path (append load-path (list (expand-file-name my-path)))))

;; Add ~/.emacs.d
(prepend-path user-emacs-directory)
;; Add ~/.emacs.d/setup-files
(prepend-path (concat user-emacs-directory "/setup-files"))
;; Add ~/.emacs.d/other-packages
(prepend-path (concat user-emacs-directory "/other-packages"))
;; Add all subdirectories under ~/.emacs.d/other-packages to the load-path
(let ((default-directory (concat user-emacs-directory "/other-packages")))
  (normal-top-level-add-subdirs-to-load-path))
;; Add all subdirectories under elpa to the load-path
(let ((default-directory (concat user-emacs-directory "/elpa")))
  (normal-top-level-add-subdirs-to-load-path))

;; Auto install the required packages
;; Source: https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
(require 'cl)
(require 'package)
;; Add melpa package source when using package list
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun my-packages-installed-p ()
  "Check if all packages in `my-packages' are installed."
  (every #'package-installed-p my-packages))

(defun my-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package my-packages)
    (add-to-list 'my-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun my-require-packages (packages)
  "Ensure PACKAGES are installed. Missing packages are installed automatically."
  (mapc #'my-require-package packages))

(defalias 'my-ensure-module-deps 'my-require-packages)

(defun my-install-packages ()
  "Install all packages listed in `my-packages'."
  (unless (my-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (my-require-packages my-packages)))

;; run package installation
(my-install-packages)

(defmacro my-auto-install (extension package mode)
  "When file with EXTENSION is opened triggers auto-install of PACKAGE.
PACKAGE is installed only if not already present.  The file is opened in MODE."
  `(add-to-list 'auto-mode-alist
                `(,extension . (lambda ()
                                 (unless (package-installed-p ',package)
                                   (package-install ',package))
                                 (,mode)))))

(defvar my-auto-install-alist
  '(
    ("\\.latex\\'" auctex LaTeX-mode)
    ("\\.markdown\\'" markdown-mode markdown-mode)
    ("\\.md\\'" markdown-mode markdown-mode)
    ("PKGBUILD\\'" pkgbuild-mode pkgbuild-mode)
    ))

;; markdown-mode doesn't have autoloads for the auto-mode-alist
;; so we add them manually if it's already installed
(when (package-installed-p 'markdown-mode)
  (add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode)))

(when (package-installed-p 'pkgbuild-mode)
  (add-to-list 'auto-mode-alist '("PKGBUILD\\'" . pkgbuild-mode)))

;; build auto-install mappings
(mapc
 (lambda (entry)
   (let ((extension (car entry))
         (package (cadr entry))
         (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (my-auto-install extension package mode))))
 my-auto-install-alist)
;; end of auto package installation code
;;

(provide 'setup-packages)
