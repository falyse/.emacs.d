;; Time-stamp: <2017-11-13 07:41:28 cfricano>

;; Miscellaneous config not categorized in other setup-* files

(fset 'yes-or-no-p 'y-or-n-p) ;; Use y or n instead of yes or no

;; Enable conversion of the selected region to upper case using `C-x C-u`
(put 'upcase-region 'disabled nil)

;; Enable conversion of the selected region to lower case using `C-x C-l`
(put 'downcase-region 'disabled nil)

;; Do not make mouse wheel accelerate its action (example: scrolling)
(setq mouse-wheel-progressive-speed nil)
;; Enable shell-script mode for these files automatically
;;cef (setq auto-mode-alist
;;cef       (append
;;cef        '(
;;cef          ("\\.setup\\'" . shell-script-mode)
;;cef          ("\\.cfg\\'"   . shell-script-mode)
;;cef          ) auto-mode-alist))

;; Execute the script in current buffer
;; Source: http://ergoemacs.org/emacs/elisp_run_current_file.html
(defun xah-run-current-file ()
  "Execute the current file.
For example, if the current buffer is the file xx.py,
then it'll call “python xx.py” in a shell.
The file can be php, perl, python, ruby, javascript, bash, ocaml, vb, elisp.
File suffix is used to determine what program to run.
If the file is emacs lisp, run the byte compiled version if exist."
  (interactive)
  (let* (
         (suffixMap
          `(
            ("py"  . "python")
            ("rb"  . "ruby")
            ("sh"  . "bash")
            ("csh" . "tcsh")
            ("pl"  . "perl")))
         (fName (buffer-file-name))
         (fSuffix (file-name-extension fName))
         (progName (cdr (assoc fSuffix suffixMap)))
         (cmdStr (concat progName " \""   fName "\"")))

    (when (buffer-modified-p)
      (when (y-or-n-p "Buffer modified. Do you want to save first?")
        (save-buffer) ) )

    (if (string-equal fSuffix "el") ; special case for emacs lisp
        (load (file-name-sans-extension fName))
      (if progName
          (progn
            ;; (view-echo-area-messages)
            (message "Running…")
            (shell-command cmdStr "*xah-run-current-file output*" ))
        (message "No recognized program file suffix for this file.")))))

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
;;(defadvice ffap-file-at-point (after ffap-file-at-point-after-advice ())
;;  (if (string= ad-return-value "/")
;;      (setq ad-return-value nil)))

;; Patched version to fix this issue:
;; In Verilog/C/C++, comments can begin with //.
;; Here's an example comment,
;; //This is a comment
;; I like to use the find-file-at-point feature. If my cursor is on the
;; file name in `include "some_file.v".  But if my cursor is on the above
;; example comment and if I hit C-x C-f, emacs tries to open a tentative
;; path //This!
;; How do I selectively prevent find-file-at-point from activating? In
;; this case, when the major mode is verilog-mode, how do I NOT do
;; find-file-at-point when my cursor is on a line where the first 2
;; non-space characters are //?
;; Source: http://emacs.stackexchange.com/questions/107/how-do-i-disable-ffap-find-file-at-point-when-the-first-two-non-space-characte
(defun ffap-string-at-point (&optional mode)
  (let* ((args
          (cdr
           (or (assq (or mode major-mode) ffap-string-at-point-mode-alist)
               (assq 'file ffap-string-at-point-mode-alist))))
         next-comment
         (pt (point))
         (beg (if (use-region-p)
                  (region-beginning)
                (save-excursion
                  (skip-chars-backward (car args))
                  (skip-chars-forward (nth 1 args) pt)
                  (save-excursion
                    (setq next-comment
                          (progn (comment-search-forward (line-end-position) t)
                                 (point))))
                  (point))))
         (end (if (use-region-p)
                  (region-end)
                (save-excursion
                  (skip-chars-forward (car args))
                  (skip-chars-backward (nth 2 args) pt)
                  (point)))))
    (when (> end next-comment)
      (setq beg next-comment))
    (setq ffap-string-at-point
          (buffer-substring-no-properties
           (setcar ffap-string-at-point-region beg)
           (setcar (cdr ffap-string-at-point-region) end)))))



; Smart parenthesis
(require 'smartparens-config)
(add-hook 'cperl-mode-hook #'smartparens-mode)


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

;; (4) How to insert superscript
;; `C-x 8 ^ 2` inserts ²

;; (5) Killing buffers from an emacsclient frame
;; `C-x #`   Kills the buffer in emacsclient frame without killing the frame
;; `C-x 5 0` Kills the emacsclient frame

;; (6)
;; `C-q' is boudn to `quoted-insert'
;; Example: Pressing `C-q C-l' inserts the `^l' character (form feed):  

;; (7)
;; The way to figure out how to type a particular key combination or to know
;; what a particular key combination does, do help on a key `C-h k`, and type
;; the keystrokes you're interested in. What Emacs shows in the Help buffer is
;; the string you can pass to the macro 'kbd.

;; (8) How to know what the current major mode is?
;; Do `M-:`, type the following `(message "%s" major-mode)` and press Return.
