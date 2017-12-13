;; Source: 
;; https://snarfed.org/why_i_run_shells_inside_emacs
;; https://snarfed.org/why_i_dont_run_shells_inside_emacs

(require 'tramp)

(custom-set-variables
;;ces  '(tramp-default-method "ssh")          ; uses ControlMaster
 '(comint-scroll-to-bottom-on-input t)  ; always insert at the bottom
 '(comint-scroll-to-bottom-on-output nil) ; always add output at the bottom
 '(comint-scroll-show-maximum-output t) ; scroll to show max possible output
 ;; '(comint-completion-autolist t)     ; show completion list when ambiguous
 '(comint-input-ignoredups t)           ; no duplicates in command history
 '(comint-completion-addsuffix t)       ; insert space/slash after file completion
 ;; '(comint-buffer-maximum-size 20000)    ; max length of the buffer in lines
 '(comint-buffer-maximum-size 10000)    ; max length of the buffer in lines
 '(comint-prompt-read-only nil)         ; if this is t, it breaks shell-command
 '(comint-get-old-input (lambda () "")) ; what to run when i press enter on a
                                        ; line above the current prompt
 '(comint-input-ring-size 5000)         ; max shell history size
 '(protect-buffer-bury-p nil)
)

(setenv "PAGER" "cat")

;; truncate buffers continuously
(add-hook 'comint-output-filter-functions 'comint-truncate-buffer)

;;ces (defun make-my-shell-output-read-only (text)
;;ces   "Add to comint-output-filter-functions to make stdout read only in my shells."
;;ces   (if (member (buffer-name) my-shells)
;;ces       (let ((inhibit-read-only t)
;;ces             (output-end (process-mark (get-buffer-process (current-buffer)))))
;;ces         (put-text-property comint-last-output-start output-end 'read-only t))))
;;ces (add-hook 'comint-output-filter-functions 'make-my-shell-output-read-only)
;;ces 
;;ces (defun my-dirtrack-mode ()
;;ces   "Add to shell-mode-hook to use dirtrack mode in my shell buffers."
;;ces   (when (member (buffer-name) my-shells)
;;ces     (shell-dirtrack-mode 0)
;;ces     (set-variable 'dirtrack-list '("^.*[^ ]+:\\(.*\\)>" 1 nil))
;;ces     (dirtrack-mode 1)))
;;ces (add-hook 'shell-mode-hook 'my-dirtrack-mode)

; interpret and use ansi color codes in shell output windows
(setq ansi-color-map (ansi-color-make-color-map))
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun set-scroll-conservatively ()
  "Add to shell-mode-hook to prevent jump-scrolling on newlines in shell buffers."
  (set (make-local-variable 'scroll-conservatively) 10))
(add-hook 'shell-mode-hook 'set-scroll-conservatively)

;; i think this is wrong, and it buries the shell when you run emacsclient from
;; it. temporarily removing.
;; (defun unset-display-buffer-reuse-frames ()
;;   "Add to shell-mode-hook to prevent switching away from the shell buffer
;; when emacsclient opens a new buffer."
;;   (set (make-local-variable 'display-buffer-reuse-frames) t))
;; (add-hook 'shell-mode-hook 'unset-display-buffer-reuse-frames)

;; make it harder to kill my shell buffers
;;ces (require 'protbuf)
;;ces(add-hook 'shell-mode-hook 'protect-process-buffer-from-kill-mode)

(defun make-comint-directory-tracking-work-remotely ()
  "Add this to comint-mode-hook to make directory tracking work
while sshed into a remote host, e.g. for remote shell buffers
started in tramp. (This is a bug fix backported from Emacs 24:
http://comments.gmane.org/gmane.emacs.bugs/39082"
  (set (make-local-variable 'comint-file-name-prefix)
       (or (file-remote-p default-directory) "")))
(add-hook 'comint-mode-hook 'make-comint-directory-tracking-work-remotely)

;;ces (defun enter-again-if-enter ()
;;ces   "Make the return key select the current item in minibuf and shell history isearch.
;;ces An alternate approach would be after-advice on isearch-other-meta-char."
;;ces   (when (and (not isearch-mode-end-hook-quit)
;;ces              (equal (this-command-keys-vector) [13])) ; == return
;;ces     (cond ((active-minibuffer-window) (minibuffer-complete-and-exit))
;;ces           ((member (buffer-name) my-shells) (comint-send-input)))))
;;ces (add-hook 'isearch-mode-end-hook 'enter-again-if-enter)

;;ces (defadvice comint-previous-matching-input
;;ces     (around suppress-history-item-messages activate)
;;ces   "Suppress the annoying 'History item : NNN' messages from shell history isearch.
;;ces If this isn't enough, try the same thing with
;;ces comint-replace-by-expanded-history-before-point."
;;ces   (let ((old-message (symbol-function 'message)))
;;ces     (unwind-protect
;;ces       (progn (fset 'message 'ignore) ad-do-it)
;;ces     (fset 'message old-message))))
;;ces 
;;ces (defadvice comint-send-input (around go-to-end-of-multiline activate)
;;ces   "When I press enter, jump to the end of the *buffer*, instead of the end of
;;ces the line, to capture multiline input. (This only has effect if
;;ces `comint-eol-on-send' is non-nil."
;;ces   (flet ((end-of-line () (end-of-buffer)))
;;ces     ad-do-it))

;; not sure why, but comint needs to be reloaded from the source (*not*
;; compiled) elisp to make the above advise stick.
;;ces (load "comint.el.gz")

;; for other code, e.g. emacsclient in TRAMP ssh shells and automatically
;; closing completions buffers, see the links above.

;; -------------------------------------------------
;; multi-term setup
;;(require 'multi-term)
;;(setq multi-term-program "/usr/local/bin/tcsh")

;; -------------------------------------------------
;; multi-eshell setup
;;(require 'multi-eshell)
;;(defvar multi-eshell-function `(shell) )

;; -------------------------------------------------
;; shell-switcher setup
(require 'shell-switcher)
(setq shell-switcher-mode t)
(setq shell-switcher-new-shell-function 'shell-switcher-make-shell)


(setq setup-shell-loaded t)
(provide 'setup-shell)
