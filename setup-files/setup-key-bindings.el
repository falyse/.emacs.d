;; KEY BINDINGS

;; The way to figure out how to type a particular key combination or to know
;; what a particular key combination does, do help on a key `C-h k`, and type
;; the keystrokes you're interested in. What Emacs shows in the Help buffer is
;; the string you can pass to the macro 'kbd.

;;(global-set-key [f1]       'goto-line) ;; Default `M-g M-g` for `goto-line'

(when (boundp 'setup-highlight-loaded)
  (global-set-key [C-f1]  'highlight-frame-toggle)
  (global-set-key [f1]    'clear-highlight-frame)
  (global-set-key [M-f1]  'auto-highlight-symbol-mode))

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
  (global-set-key [f6]       'toggle-comment-on-line-or-region))
;; (global-set-key [S-f6]     'uncomment-region) ;; and also to add comment to end of current line

;;ces (when (boundp 'setup-occur-loaded)
;;ces   (global-set-key [f6]     'multi-occur-in-this-mode) ;; search the regexp in all buffers with current major mode
;;ces   (global-set-key [C-f6]   'multi-occur-in-matching-buffers) ;; search the regexp in buffers matching the regexp
;;ces   )

;; (global-set-key [f7] )

;; F8 key can't be used as it launches the VNC menu
;; It can though be used with shift/ctrl/alt keys
(when (boundp 'setup-visual-loaded)
  (global-set-key [S-f8]   'toggle-presentation-mode))

(global-set-key [f9]       'eval-region)
(global-set-key [S-f9]     'eshell)

(when (boundp 'setup-sos-loaded)
  (global-set-key [f10]    'sos-co)
  (global-set-key [S-f10]  'sos-ci)
  (global-set-key [C-f10]  'sos-discardco))

;;cef (global-set-key [f11]       'menu-bar-mode) ;; Toggle the menu bar: File|Edit|Options|..
;;ces (global-set-key [S-f11]     'session-save) ;; Save the current desktop session
(when (boundp 'setup-spell-loaded)
  (global-set-key [f11] 'flyspell-auto-correct-word) ;; auto correct the last incorrect word
  )

(global-set-key [f12]       'revert-buffer)
(when (boundp 'setup-windows-buffers-loaded)
  (global-set-key [S-f12]   'revert-all-buffers))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Unset keys
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-unset-key (kbd "C-z")) ;; it is bound to `suspend-frame' by default
;; suspend-frame can be called using `C-x C-z` too. And `C-z` is used as prefix
;; key in tmux. So removing the `C-z` binding from emacs makes it possible to
;; use emacs in -nw (no window) mode in tmux if needed without any key binding
;; contention.


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

;; Make Control+mousewheel do increase/decrease font-size
;; Source: http://ergoemacs.org/emacs/emacs_mouse_wheel_config.html
(global-unset-key (kbd "<C-down-mouse-1>")) ;; it is bound to `mouse-buffer-menu'
;; by default. It is inconvenient when that mouse menu pops up when I don't need
;; it to. And actually I have never used that menu :P
;;(global-set-key (kbd "<C-mouse-1>") 'font-size-reset) ;; C + left mouse click
(global-set-key (kbd "<C-mouse-4>") 'font-size-incr) ;; C + wheel-up
(global-set-key (kbd "<C-mouse-5>") 'font-size-decr) ;; C + wheel-down

;; Make Alt+mousewheel scroll the other buffer
(global-set-key (kbd "<M-mouse-4>") 'scroll-other-window-down-dont-move-point) ;; M + wheel-up
(global-set-key (kbd "<M-mouse-5>") 'scroll-other-window-up-dont-move-point) ;; M + wheel-down

(windmove-default-keybindings)
;; Make windmove work in org-mode:
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

(global-set-key (kbd "C-c t")     'toggle-window-split) ;; convert between horz-split <-> vert-split
(global-set-key (kbd "C-c s")     'rotate-windows) ;; rotate windows clockwise. This will do the act of swapping windows if the frame is split into only 2 windows

;; (global-set-key (kbd "<C-S-left>")  'full-screen-left)  ;; maximize window on left monitor
;; (global-set-key (kbd "<C-S-right>") 'full-screen-right) ;; maximize window on right monitor


(global-set-key (kbd "C-x C-b")   'ibuffer) ;; replace buffer-menu with ibuffer

(when (boundp 'setup-windows-buffers-loaded)
  ;; overriding the `C-x C-p binding with `mark-page' command
  (global-set-key (kbd "C-x C-p") 'show-copy-buffer-file-name)
  (global-set-key (kbd "C-x C-k") 'delete-current-buffer-file)
  (global-set-key (kbd "C-x C-r") 'rename-current-buffer-file)
  (define-key modi-map (kbd "b")  'switch-to-scratch-and-back) ;; C-x m b

  ;;(global-set-key (kbd "C-x C-o")   'ido-find-recentf)
  (global-set-key (kbd "C-x C-o")   'helm-recentf)
  
  (define-key modi-map (kbd "l")    'load-current-file) ;; C-x m l
  (global-set-key (kbd "C-S-t")     'undo-kill-buffer) ;; same shortcut as for reopening closed tabs in browsers
  (global-set-key (kbd "<M-up>")    'scroll-down-dont-move-point)
  (global-set-key (kbd "<M-down>")  'scroll-up-dont-move-point)
  ;; Change the default `M-left` key binding from `left-word'
  ;; The same function anyways is also bound to `C-left`
  (global-set-key (kbd "<M-left>")  'scroll-other-window-down-dont-move-point)
  ;; Change the default `M-right` key binding from `right-word'
  ;; The same function anyways is also bound to `C-right`
  (global-set-key (kbd "<M-right>") 'scroll-other-window-up-dont-move-point)
  (define-key modi-map (kbd "f")    'full-screen-left) ;; C-x m f
)

;; Print to printer defined by env var `PRINTER'
(define-key modi-map (kbd "p")    'ps-print-buffer-with-faces) ;; C-x m p

;; (global-set-key (kbd "<C-tab>")   'other-window) ;; alternative shortcut for `C-x o`
;; ;; Cycle the buffers in reverse order than what happens with `C-x o`
;; (global-set-key (kbd "C-x O")
;;                 (lambda ()
;;                   (interactive)
;;                   (other-window -1)))

(when (boundp 'setup-dired-loaded)
  ;; Change the default `C-x C-d` key binding from `ido-list-directory'
  ;; dired magic buffer is now used instead of the default dired for the same action
  (global-set-key (kbd "C-x C-d")
                  (lambda()
                    (interactive)
                    (dired-single-magic-buffer default-directory)))
  ;; Change the default `C-x C-j` key binding from `dired-jump'
  ;; Opens dired-single-magic-buffer but asks which directory to open that dired
  ;; buffer for
  (global-set-key (kbd "C-x C-j") 'dired-single-magic-buffer)
  )

(define-key modi-map (kbd "y")    'bury-buffer) ;; C-x m y

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

  (global-set-key (kbd "C-S-d")       'duplicate-current-line-or-region)

  ;; override the binding of `C-x =` for `what-cursor-position'
  (global-set-key (kbd "C-x =")       'align-to-equals) ;; align all = signs in selected region
  (global-set-key (kbd "C-x \\")      'align-regexp)  ;; align selected region to the entered regexp
  ;; align multiple columns in the selected region. Of course all the selected
  ;; lines must have the same number of columns of groups of non-space characters
  (global-set-key (kbd "C-x |")       'align-columns)

  (global-set-key (kbd "C-k")         'kill-line)
  (global-set-key (kbd "C-S-k")       'smart-kill-whole-line)
  ;; override the binding of `C-o` for `open-line'
  (global-set-key (kbd "C-o")         'smart-open-line)

  (define-key modi-map (kbd "x")      'eval-and-replace-last-sexp) ;; C-x m x
  )

(when (boundp 'setup-drag-stuff-loaded)
  (global-set-key (kbd "<C-S-up>")    'drag-stuff-up)
  (global-set-key (kbd "<C-S-down>")  'drag-stuff-down)
  ;;(global-set-key (kbd "<C-S-left>")  'drag-stuff-left)
  ;;(global-set-key (kbd "<C-S-right>") 'drag-stuff-right)
  )

(when (boundp 'setup-editing-loaded)
  (global-set-key            (kbd "C-j") 'pull-up-line))

(global-set-key (kbd "M-j")          'comment-indent-new-line)
(global-set-key (kbd "C-M-j")        'comment-indent-new-line)

(when (boundp 'setup-search-loaded)
  (global-set-key (kbd "C-S-s")      'isearch-current-symbol)
  (global-set-key (kbd "C-S-r")      'isearch-backward-current-symbol)
  (define-key modi-map (kbd "s")     'search-all-buffers) ;; C-x m s

  ;; replace the emacs default query-replace
  (global-set-key (kbd "M-%")        'anzu-query-replace)
  (global-set-key (kbd "C-c r")      'anzu-replace-at-cursor-thing)

  ;; swoop
  ;; https://github.com/ShingoFukuyama/helm-swoop
  ;; (global-set-key (kbd "M-i")   'swoop)
  ;; (global-set-key (kbd "M-I")   'swoop-multi)
  ;; (global-set-key (kbd "M-o")   'swoop-pcre-regexp)
  (global-set-key (kbd "M-i") 'helm-swoop)
  ;; (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  (global-set-key (kbd "M-I") 'helm-swoop-without-pre-input)
  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
  ;; Transition
  ;; isearch     > press [C-o] > swoop
  ;; (define-key isearch-mode-map (kbd "C-o")      'swoop-from-isearch)
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; swoop       > press [C-o] > swoop-multi
  ;; (define-key swoop-map (kbd "C-o")             'swoop-multi-from-swoop)
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)
  ;; Move up and down like isearch
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)
  ;; Resume
  ;; C-u M-x swoop : Use last used query
  ;; Swoop Edit Mode
  ;; During swoop, press [C-c C-e]
  ;; You can edit synchronously
  )

(when (boundp 'setup-visual-regexp-loaded)
  ;; replace the emacs default query-replace-regexp
  (global-set-key (kbd "C-M-%")      'vr/query-replace)
  (global-set-key (kbd "C-c q")      'vr/query-replace))

(when (boundp 'setup-highlight-loaded)
  (define-key modi-map (kbd "h")          'highlight-frame-toggle)     ;; C-x m h
  (define-key modi-map (kbd "H")          'clear-highlight-frame)      ;; C-x m H
  (global-set-key (kbd "C-*")             'auto-highlight-symbol-mode)
  (global-set-key (kbd "<C-kp-multiply>") 'auto-highlight-symbol-mode)
  )

(when (boundp 'setup-ag-loaded)
  (define-key modi-map (kbd "a") 'ag-project-regexp) ;; C-x m a
  (define-key modi-map (kbd "g") 'ag-project-regexp) ;; C-x m g
  )

(global-set-key (kbd "M-/")          'indent-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Visual | Looks
;; hl-line+ package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x t")     'toggle-truncate-lines)

(when (boundp 'setup-hl-line+-loaded)
  (global-set-key (kbd "C-c C-f") 'hl-line-flash) ;; flash the current line
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; multiple-cursors package
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-multiple-cursors-loaded)
  (global-set-key (kbd "C-S-c C-S-c")   'mc/edit-lines)
  (global-set-key (kbd "C->")           'mc/mark-next-like-this)
  (global-set-key (kbd "C-<")           'mc/mark-previous-like-this)
  (global-set-key (kbd "C-c C-<")       'mc/mark-all-like-this)

  (global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)

  (define-key modi-map (kbd "m")        'mc/mark-all-like-this-dwim) ;; C-x m m
  (define-key modi-map (kbd "r")        'set-rectangular-region-anchor) ;; C-x m r
  )


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; helm overrides
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-helm-loaded)
  (global-set-key (kbd "M-x")     'helm-M-x)  ;; commands
  (global-set-key (kbd "C-x C-f") 'helm-find-files)  ;; find-files
  (global-set-key (kbd "C-x b")   'helm-for-files)  ;; switch-to-buffer
  ;(global-set-key (kbd "C-x b")   'persp-helm-for-files)  ;; switch-to-buffer
  (global-set-key (kbd "M-s o")   'helm-occur)  ;; occur
  ;(global-set-key (kbd "C-x k")   'persp-kill-buffer)
  (global-set-key (kbd "C-x f")   'helm-projectile)
  (global-set-key (kbd "M-y")     'helm-show-kill-ring)
  (global-set-key (kbd "C-c h x") 'helm-register)
  
  ;(define-key helm-map "\t" 'helm-execute-persistent-action)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
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
  ;; bind er/expand-region to `C-\' instead of `C-=' because `=' sign clashes
  ;; when trying to wrap a selection with `=' in org-mode using the wrap-region
  ;; package
  (global-set-key (kbd "C-\\") 'my-expand-region))


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

(when (boundp 'setup-ace-window-loaded)
  (global-set-key (kbd "C-x o")  'ace-window)
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Registers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Text-Registers.html#Text-Registers
;;     C-x r s REG <- Copy region to register REG
;; C-u C-x r s REG <- CUT region and move to register REG
;;     C-x r i REG <- Insert text from register REG
;;     C-x r a REG <- Append region to text in register REG
;;     C-x r + REG <- Append region to text in register REG if REG already
;;                    contains text; but increments the content of REG if the
;;                    content is a number.

(when (boundp 'setup-iregister-loaded)
  (define-key modi-map (kbd "i") 'iregister-latest-text) ;; C-x m i
  ;; If region is active then `iregister-point-or-text-to-register' command stores a
  ;; text to any empty register, otherwise it stores a point.
  (global-set-key (kbd "M-w") 'iregister-point-or-text-to-register-kill-ring-save) ;; Replace normal copy function
  (global-set-key (kbd "C-w") 'iregister-copy-to-register-kill) ;; Replace normal 'cut' function

  ;; Copy the selection and append to the latest register
  (global-set-key (kbd "C-x r a") 'iregister-append-to-latest-register)
  ;; Delete the selection and append to the latest register
  (global-set-key (kbd "C-x r A") 'iregister-append-to-latest-register-delete)

  ;; Assuming that there are already stored some texts (by means of `copy-to-register'
  ;; or `iregister-copy-to-register' command) in the registers. Execute
  ;; `iregister-text' and the minibuffer will display the text stored in some
  ;; register.
  ;; Key bindings when the `iregister-text minibuffer is active:
  ;;   RET        - The selected text will be inserted
  ;;   l          - View the latest text stored in the registers
  ;;   n          - View next text previously stored in the registers
  ;;   p          - View previous text previously stored in the registers
  ;;   d          - Delete current text from the register
  ;;   q or `C-g' - To quit from the minibuffer
  ;;   a          - Append the selected text to the current text registry
  ;;   A          - Prepend the selected text to the current text registry
  (global-set-key (kbd "M-n") 'iregister-jump-to-next-marker)
  (global-set-key (kbd "M-p") 'iregister-jump-to-previous-marker)
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Code Folding
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x x")      'fold-dwim-toggle)
(global-set-key (kbd "C-x X")    'fold-dwim-hide-all)
(global-set-key (kbd "C-x M-x")  'fold-dwim-show-all)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Jump to last change
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-x C-/") 'goto-last-change)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Shell
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-:") 'shell)
(global-set-key (kbd "C-;") (kbd "C-u C-:"))  ; force new shell
(global-set-key (kbd "C-'") 'rename-buffer)
;(global-set-key (kbd "C-x g") 'term-projectile-switch-to)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; other
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (boundp 'setup-misc-loaded)
  (global-set-key (kbd "C-x C-c") 'confirm-kill-emacs))
;;ces (when (boundp 'setup-desktop-loaded)
;;ces   (global-set-key (kbd "C-x C-c") 'savedesktop-kill-emacs))


(provide 'setup-key-bindings)
