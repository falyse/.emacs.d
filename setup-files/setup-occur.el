;; Time-stamp: <2013-12-13 14:15:51 kmodi>

;; Occur mode
;; Source: http://www.masteringemacs.org/articles/2011/07/20/searching-buffers-occur-mode/

;; M-x occur                            - only search the active buffer
;; M-x multi-occur                      - search the buffers you specify
;; M-x multi-occur-in-matching-buffers  - search all buffers that match a given regexp pattern

(eval-when-compile
  (require 'cl))

(defun get-buffers-matching-mode (mode)
  "Returns a list of buffers where their major-mode is equal to MODE"
  (let ((buffer-mode-matches '()))
    (dolist (buf (buffer-list))
      (with-current-buffer buf
        (if (eq mode major-mode)
            (add-to-list 'buffer-mode-matches buf))))
    buffer-mode-matches))

(defun multi-occur-in-this-mode ()
  "Show all lines matching REGEXP in buffers with this major mode."
  (interactive)
  (multi-occur
   (get-buffers-matching-mode major-mode)
   (car (occur-read-primary-args)))
  (windmove-down) ;; Move to the lower window (hoping that the *Occur* windows
                  ;; open in the bottom as usual). I believe installing popwin
                  ;; package ensures that *Occur* opens in a "floating" window
                  ;; at bottom.
  )


(setq setup-occur-loaded t)
(provide 'setup-occur)
