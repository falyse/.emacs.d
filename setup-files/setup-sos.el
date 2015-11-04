;; Time-stamp: <2015-09-10 09:49:04 cfricano>

;; SOS version managment system

;; Running shell commands from emacs
(defun sos-co ()
  "Perform soscmd co shell command on the current buffer file
and update the buffer."
  (interactive)
  (shell-command
   (concat "module load sos; soscmd co " buffer-file-name))
  (revert-buffer-no-confirm))

(defun sos-discardco ()
  "Perform soscmd discard co shell command on the current buffer file
and update the buffer."
  (interactive)
  (shell-command
   (concat "module load sos; soscmd discardco " buffer-file-name))
  (revert-buffer-no-confirm))

(defun sos-discardco-force ()
  "Perform forced soscmd discard co shell command on the current buffer file
and update the buffer."
  (interactive)
  (shell-command
   (concat "module load sos; soscmd discardco -F " buffer-file-name))
  (revert-buffer-no-confirm))

(defun sos-diff ()
  "Do a diff between the file in workarea and the last checked in version in SOS "
  (interactive)
  (shell-command
   (concat "module load sos; soscmd dif " buffer-file-name)))

(defun sos-ci (revisionlog)
  "Perform soscmd ci shell command on the current buffer file
and update the buffer."
  (interactive "sRevision Log: ")
  (shell-command
   (concat "module load sos; soscmd ci -aLog=\"" revisionlog "\" " buffer-file-name))
  (revert-buffer-no-confirm))

(defun sos-up ()
  "Perform soscmd update shell command and update all the buffers."
  (interactive)
  (shell-command
   "module load sos; soscmd update")
  (revert-all-buffers))

(setq setup-sos-loaded t)
(provide 'setup-sos)
