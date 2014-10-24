;; Time-stamp: <2014-10-24 11:13:34 cfricano>

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
(package-initialize) ;; Load emacs packages and activate them

;; Auto install the required packages
;; Source: https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el
;; Source: http://toumorokoshi.github.io/emacs-from-scratch-part-2-package-management.html
;; method to check if all packages are installed
(defun packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

;; if not all packages are installed, check one by one and install the missing ones.
(unless (packages-installed-p)
  ; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'setup-packages)
