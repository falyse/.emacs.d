;; Time-stamp: <2013-12-17 11:17:16 kmodi>

;; server setup

;; Start emacs server
;; Now all new opened files will open in the same emacs instance if
;; opened using `emacsclient FILENAME&`

(require 'server)

;; Suppress error "directory  ~/.emacs.d/server is unsafe" when
;; running on cygwin
(when (and (>= emacs-major-version 23)
           (equal window-system 'x))
  (setq server-use-tcp t)
  (defun server-ensure-safe-dir (dir) "Noop" t))

;; start a server only if one is not already running
;; `server-running-p' returns "t" if a server is already running
(when (not (server-running-p))
  (server-start))


(setq setup-server-loaded t)
(provide 'setup-server)
