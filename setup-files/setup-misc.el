;; Time-stamp: <2014-08-28 17:36:35 cfricano>

;; Miscellaneous config not categorized in other setup-* files

(fset 'yes-or-no-p 'y-or-n-p) ;; Use y or n instead of yes or no

;; Enable conversion of the selected region to upper case using `C-x C-u`
(put 'upcase-region 'disabled nil)

;; Enable conversion of the selected region to lower case using `C-x C-l`
(put 'downcase-region 'disabled nil)

; Backup files to ~/.emacs.tmp/saves
(setq backup-directory-alist `(("." . "~/.emacs.tmp/saves")))

; Save recent file list in ~/.emacs.tmp
(setq recentf-save-file "~/.emacs.tmp/.recentf")

; Keep files edited on disk up to date in emacs
(global-auto-revert-mode t)

;; Prevent accidentally killing emacs.
;; Also save current desktop every time when quitting emacs
(defun confirm-kill-emacs ()
  (interactive)
  (if (y-or-n-p-with-timeout "Do you really want to exit Emacs ? " 4 nil)
      (progn
        ;;ces (save-buffers-kill-emacs))))
        (save-buffers-kill-terminal))))

;; Insert newlines if the point is at the end of the buffer
(setq next-line-add-newlines t)


;; cef Make ffap ignore '/'
(defadvice ffap-file-at-point (after ffap-file-at-point-after-advice ())
  (if (string= ad-return-value "/")
      (setq ad-return-value nil)))


(setq setup-misc-loaded t)
(provide 'setup-misc)


;; TIPS

;; (1) Un-define a symbol/variable
;; this will make the symbol my-nasty-variable's value void
;; (makunbound 'my-nasty-variable)

;; (2) Un-define a function
;; this will make the symbol my-nasty-function's
;; function definition void
;; (fmakunbound 'my-nasty-function)

;; (3) See a variable value
;; `C-h v`, enter the variable name, Enter
;; Example: `C-h v`, `tooltip-mode`, Enter
