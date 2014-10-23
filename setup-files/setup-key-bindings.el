;; Time-stamp: <2014-08-19 19:18:39 cfricano>

;; KEY BINDINGS

;; The way to figure out how to type a particular key combination or to know
;; what a particular key combination does, do help on a key `C-h k`, and type
;; the keystrokes you're interested in. What Emacs shows in the Help buffer is
;; the string you can pass to the macro 'kbd.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ** Binding the Function keys **
;; verilog-mode package
;; highlight-symbol package
;; smart-compile package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key [f1]       'goto-line) ;; Default `M-g M-g` for `goto-line'

(when (boundp 'setup-highlight-loaded)
  (global-set-key [C-f3]  'highlight-symbol-at-point)
  (global-set-key [f3]    'highlight-symbol-next)
  (global-set-key [f2]    'highlight-symbol-prev)
  (global-set-key [C-f2]  'highlight-symbol-remove-all)
  (global-set-key [M-f3]  'highlight-symbol-query-replace))

(global-set-key [f4]       'kmacro-end-or-call-macro) ;; end macro recording/call last macro
(global-set-key [S-f4]     'start-kbd-macro) ;; start macro recording
(global-set-key [C-f4]     'start-kbd-macro) ;; start macro recording

(when (boundp 'setup-verilog-loaded)
  (global-set-key [f5]    'verilog-goto-defun)) ;; jump to the module definition file
(when (boundp 'setup-smart-compile-loaded)
  (global-set-key [C-f5]   'save-compile-execute))

(when (boundp 'setup-editing-loaded)
  (global-set-key [f6]       'toggle-comment-on-line))
;; (global-set-key [S-f6]     'uncomment-region) ;; and also to add comment to end of current line

;;ces (when (boundp 'setup-occur-loaded)
;;ces   (global-set-key [f6]     'multi-occur-in-this-mode) ;; search the regexp in all buffers with current major mode
;;ces   (global-set-key [C-f6]   'multi-occur-in-matching-buffers) ;; search the regexp in buffers matching the regexp
;;ces   )

(global-set-key [C-f7]     'ps-print-buffer-with-faces) ;; print to printer defined by env var `PRINTER'

;; F8 key can't be used as it launches the VNC menu
;; It can though be used with shift/ctrl/alt keys
;; (global-set-key [S-f8]     )

(global-set-key [f9]       'eval-region)
(global-set-key [S-f9]     'eshell)

(when (boundp 'setup-sos-loaded)
  (global-set-key [f10]    'sos-co)
  (global-set-key [S-f10]  'sos-ci)
  (global-set-key [C-f10]  'sos-discardco))

(global-set-key [f11]       'menu-bar-mode) ;; Toggle the menu bar: File|Edit|Options|..
;;ces (global-set-key [S-f11]     'session-save) ;; Save the current desktop session

(global-set-key [f12]       'revert-buffer)
(when (boundp 'setup-windows-buffers-loaded)
  (global-set-key [S-f12]   'revert-all-buffers))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom key map: modi-map
;; Source: http://stackoverflow.com/questions/1024374/how-can-i-make-c-p-an-emacs-prefix-key-for-develperlysense
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-prefix-command 'modi-map)
(global-set-key (kbd "C-x m") 'modi-map) ;; overriding the default binding to `compose-mail'


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; smex package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-smex-loaded)
  ;; reworking key bindings for smex
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; old M-x
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Windows, Buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Resize windows
;; Use co-located , . ; ' keys to control window size
(global-set-key (kbd "C-,")       'shrink-window-horizontally)
(global-set-key (kbd "C-.")       'enlarge-window-horizontally)
(global-set-key (kbd "C-;")       'shrink-window) ;; make window shorter
;; Don't let verilog-mode redefine the `C-;` key to (electric-verilog-semi-with-comment)
(when (boundp 'setup-verilog-loaded)
  (add-hook 'verilog-mode-hook
            '(lambda ()
               (define-key verilog-mode-map (kbd "C-;") 'shrink-window))))
(global-set-key (kbd "C-'")       'enlarge-window) ;; make window taller

;;ces (global-set-key (kbd "C-c k")     'windmove-up) ;; switch to buffer on top
;;ces (global-set-key (kbd "C-c j")     'windmove-down) ;; switch to buffer on bottom
;;ces (global-set-key (kbd "C-c h")     'windmove-left) ;; switch to buffer on left
;;ces (global-set-key (kbd "C-c l")     'windmove-right) ;; switch to buffer on right
(windmove-default-keybindings)
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(global-set-key (kbd "C-c t")     'toggle-window-split) ;; convert between horz-split <-> vert-split
(global-set-key (kbd "C-c s")     'rotate-windows) ;; rotate windows clockwise. This will do the act of swapping windows if the frame is split into only 2 windows

(global-set-key (kbd "C-x C-b")   'ibuffer) ;; replace buffer-menu with ibuffer

(when (boundp 'setup-windows-buffers-loaded)
  ;; overriding the `C-x C-p binding with `mark-page' command
  (global-set-key (kbd "C-x C-p") 'show-copy-buffer-file-name)
  (global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)
  (global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
  (define-key modi-map (kbd "b")  'switch-to-scratch-and-back) ;; C-x m b
  ;; overriding the `C-x C-o` binding with `delete-blank-lines'
  (global-set-key (kbd "C-x C-o") 'recentf-open-files)
  (define-key modi-map (kbd "l")  'load-current-file) ;; C-x m l
  (global-set-key (kbd "C-S-t")   'undo-kill-buffer) ;; same shortcut as for reopening closed tabs in browsers
)

;; Cycle the buffers in reverse order than what happens with `C-x o`
(global-set-key (kbd "<C-tab>")   'other-window) ;; alternative shortcut for `C-x o`
(global-set-key (kbd "C-x O")
                (lambda ()
                  (interactive)
                  (other-window -1)))

(when (boundp 'setup-dired-loaded)
  ;; Change the default `C-x C-d` key binding from `ido-list-directory'
  (global-set-key (kbd "C-x C-d") 'dired-single-magic-buffer)
  ;; Change the default `C-x C-j` key binding from  `dired-jump'
  ;; dired magic buffer is now used instead of the default dired for the same action
  (global-set-key (kbd "C-x C-j")
                  (lambda()
                    (interactive)
                    (dired-single-magic-buffer default-directory)))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Navigation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Move more quickly
(global-set-key (kbd "C-S-n")
                (lambda ()
                  (interactive)
                  (ignore-errors (next-line 5))))

(global-set-key (kbd "C-S-p")
                (lambda ()
                  (interactive)
                  (ignore-errors (previous-line 5))))

(global-set-key (kbd "C-S-f")
                (lambda ()
                  (interactive)
                  (ignore-errors (forward-char 5))))

(global-set-key (kbd "C-S-b")
                (lambda ()
                  (interactive)
                  (ignore-errors (backward-char 5))))

;; Scroll down; does the same as `M-v'. It makes scrolling up and down quick
;; as the `scroll-up' is bound to `C-v'.
(global-set-key (kbd "C-S-v") 'scroll-down)

;; NOTE: `C-[` key combination is the same as pressing the meta key Esc|Alt
;; Do NOT reconfigure that key combination.
(global-set-key (kbd "C-}") 'forward-paragraph)
(global-set-key (kbd "M-}") 'forward-paragraph) ;; default key-binding for `forward-paragraph'
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "C-{") 'backward-paragraph)
(global-set-key (kbd "M-{") 'backward-paragraph) ;; default key-binding for `backward-paragraph'
(global-set-key (kbd "M-[") 'backward-paragraph)

(global-set-key (kbd "C-c f") 'follow-mode) ;; Toggle Follow-mode
;; http://www.gnu.org/software/emacs/manual/html_node/emacs/Follow-Mode.html
;; Follow-mode is a minor mode that makes 2 or more windows, all showing the same
;; buffer/file, scroll as a single tall virtual window. To use Follow mode, go
;; to a frame with just one window, split it into two side-by-side windows using
;; C-x 3, and then type M-x follow-mode. From then on, you can edit the buffer
;; in either of the windows, or scroll either one; the other window follows it.
;; In Follow mode, if you move point outside the portion visible in one window
;; and into the portion visible in the other window, that selects the other
;; window again, treating the two as if they were parts of one large window.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Editing | Search | Highlight
;; visual-regexp package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x d")        'delete-region)

(when (boundp 'setup-editing-loaded)
  (global-set-key (kbd "C-c C-d")     'insert-current-date-time)
  (global-set-key (kbd "C-c C-t")     'insert-current-time)

  (global-set-key (kbd "<C-S-up>")    'drag-stuff-up)
  (global-set-key (kbd "<C-S-down>")  'drag-stuff-down)
  (global-set-key (kbd "<C-S-left>")  'drag-stuff-left)
  (global-set-key (kbd "<C-S-right>") 'drag-stuff-right)
  (global-set-key (kbd "C-S-d")       'duplicate-current-line-or-region)

  ;; override the binding of `C-x =` for `what-cursor-position'
  (global-set-key (kbd "C-x =")       'align-to-equals) ;; align all = signs in selected region
  (global-set-key (kbd "C-x \\")      'align-regexp)  ;; align selected region to the entered regexp
  ;; align multiple columns in the selected region. Of course all the selected
  ;; lines must have the same number of columns of groups of non-space characters
  (global-set-key (kbd "C-x |")       'align-columns)

  (define-key modi-map (kbd "x")      'eval-and-replace-last-sexp) ;; C-x m x
  )

(when (boundp 'setup-visual-regexp-loaded)
  (global-set-key (kbd "C-c r")      'vr/replace)
  (global-set-key (kbd "C-c q")      'vr/query-replace))

;; Insert a newline at the current cursor location, while not moving the cursor
(global-set-key (kbd "C-o")          'open-line)
;; Join the following line onto the current one
(global-set-key (kbd "C-j")
                (lambda ()
                  (interactive)
                  (join-line -1)))
(global-set-key (kbd "M-j")          'comment-indent-new-line)
(global-set-key (kbd "C-M-j")        'comment-indent-new-line)

(when (boundp 'setup-search-loaded)
  (global-set-key (kbd "C-S-s")   'isearch-current-symbol)
  (global-set-key (kbd "C-S-r")   'isearch-backward-current-symbol)
  (define-key modi-map (kbd "s")  'search-all-buffers)) ;; C-x m s

(when (boundp 'setup-highlight-loaded)
  (define-key modi-map (kbd "h")  'highlight-frame-toggle) ;; C-x m h
  (define-key modi-map (kbd "H")  'clear-highlight-frame) ;; C-x m H
  )

(global-set-key (kbd "M-/")          'indent-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual | Looks
;; hl-line+ package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x t")     'toggle-truncate-lines)

(when (boundp 'setup-visual-loaded)
  (global-set-key (kbd "C-x C-=") 'font-size-incr)
  (global-set-key (kbd "C-x C--") 'font-size-decr)
  (global-set-key (kbd "C-x C-0") 'font-size-reset))

(when (boundp 'setup-hl-line+-loaded)
  (global-set-key (kbd "C-c C-f") 'hl-line-flash) ;; flash the current line
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-multiple-cursors-loaded)
  (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
  (global-set-key (kbd "C->")         'mc/mark-next-like-this)
  (global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
  (define-key modi-map (kbd "m")      'mc/edit-all-like-this) ;; C-x m m
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; helm-swoop package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-helm-loaded)
  (global-set-key (kbd "M-i") 'helm-multi-swoop-all)
  ;; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  (global-set-key (kbd "C-c h") 'helm-mini)
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasnippet package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-yasnippet-loaded)
  ;; unset the key binding for `C-q` which is set for `(quoted-insert ARG)`.
  ;; Example: by default pressing `C-q` and then `C-l` inserts 
  (global-unset-key (kbd "C-q"))
  ;; Now key bindings starting with C-q key sequence are used in yasnippet
  ;; bindings. Example: In verilog-mode, pressing `C-q i` inserts an if
  ;; statement. If a region is selected, the if statement wraps that region.
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-org-loaded)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c b") 'org-iswitchb)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c l") 'org-store-link))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; expand-region package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-expand-region-loaded)
  (global-set-key (kbd "C-=") 'er/expand-region))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ace-jump-mode package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-ace-jump-mode-loaded)
  (global-set-key (kbd "C-c SPC") 'ace-jump-mode)
  (global-set-key (kbd "s-SPC") 'ace-jump-mode)
  (global-set-key (kbd "C-c C-SPC") 'ace-jump-buffer))
;;         C-c SPC -> `ace-jump-word-mode'
;;     C-u C-c SPC -> `ace-jump-char-mode'
;; C-u C-u C-c SPC -> `ace-jump-line-mode'

;; Unbind ace-jump key from conflicting minor modes
(when (boundp 'setup-ace-jump-mode-loaded)
  (define-key comint-mode-map "\C-c " nil))
(when (boundp 'setup-ace-jump-mode-loaded)
  (add-hook 'org-mode-hook
            '(lambda ()
               (define-key org-mode-map "\C-c " nil))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-misc-loaded)
  (global-set-key (kbd "C-x C-c") 'confirm-kill-emacs))
;;ces (when (boundp 'setup-desktop-loaded)
;;ces   (global-set-key (kbd "C-x C-c") 'savedesktop-kill-emacs))


(provide 'setup-key-bindings)
