;; Time-stamp: <2017-12-14 09:00:03 cfricano>

;; Set up the looks of emacs

(setq default-font-size-pt 10 ;; default font size
      dark-theme          nil ;; initialize dark-theme var
      )

;;(add-to-list 'default-frame-alist
;;             '(font . "-misc-fixed-medium-r-normal--13-120-75-75-c-80-iso8859-1"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MENU/TOOL/SCROLL BARS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Turn off mouse interface early in startup to avoid momentary display
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1)) ;; do not show the menu bar with File|Edit|Options|...
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1)) ;; do not show the tool bar with icons on the top
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1)) ;; disable the scroll bars

(setq inhibit-startup-message t ;; No splash screen at startup
      scroll-step 1 ;; scroll 1 line at a time
      tooltip-mode nil ;; disable tooltip appearance on mouse hover
      )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; THEME and COLORS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq default-theme       'light)

;; soft-stone
;; dichromacy
;; 

(defun light ()
  "Activate light theme."
  (interactive)
  (setq dark-theme nil)
  (setq light-theme t)
  ;; disable other themes before setting this theme
  (disable-theme 'sanityinc-tomorrow-blue)
  (load-theme    'dichromacy)
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "burlywood" :weight bold)
                ("CANCELED" :foreground "forest green" :weight bold))))
  )

(defun dark ()
  "Activate dark theme."
  (interactive)
  (setq dark-theme t)
  (setq light-theme nil)
  ;; disable other themes before setting this theme
  (disable-theme 'dichromacy)
  (load-theme    'sanityinc-tomorrow-blue)
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "salmon" :weight bold)
                ("NEXT" :foreground "deepskyblue" :weight bold)
                ("DONE" :foreground "pale green" :weight bold)
                ("WAITING" :foreground "lightgoldenrod" :weight bold)
                ("HOLD" :foreground "burlywood" :weight bold)
                ("CANCELED" :foreground "pale green" :weight bold))))
  )

;; Load the theme ONLY after the frame has finished loading (needed especially
;; when running emacs in daemon mode)
;; Source: https://github.com/Bruce-Connor/smart-mode-line/issues/84#issuecomment-46429893
(add-to-list 'after-make-frame-functions
             (lambda (&rest frame)
               (funcall default-theme)))

;;cef (add-hook 'after-init-hook

(setq global-font-lock-mode t ;; enable font-lock or syntax highlighting globally
      font-lock-maximum-decoration t ;; use the maximum decoration level available for color highlighting
      )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rainbow parens
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)  ;; enable in all programming modes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Different background for shells
;(add-hook 'shell-mode-hook (lambda nil
;   (load-theme-buffer-local 'dichromacy (current-buffer))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONT SIZE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the font size specified in default-font-size-pt symbol
(setq font-size-pt default-font-size-pt)
;; The internal font size value is 10x the font size in points unit.
;; So a 10pt font size is equal to 100 in internal font size value.
(set-face-attribute 'default nil :height (* font-size-pt 10))

;; Below custom function are not required usually as the default C-x C-0/-/=
;; bindings do excellent job. The default binding though does not change the
;; font sizes for the text outside the buffer, example in mode-line.
;; Below functions change the font size in those areas too.
(defun font-size-incr ()
  "Increase font size by 1 pt"
  (interactive)
  (setq font-size-pt (+ font-size-pt 1))
  (set-face-attribute 'default nil :height (* font-size-pt 10)))

(defun font-size-decr ()
  "Decrease font size by 1 pt"
  (interactive)
  (setq font-size-pt (- font-size-pt 1))
  (set-face-attribute 'default nil :height (* font-size-pt 10)))

(defun font-size-reset ()
  "Reset font size to default-font-size-pt"
  (interactive)
  (setq font-size-pt default-font-size-pt)
  (set-face-attribute 'default nil :height (* font-size-pt 10)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LINE TRUNCATION / VISUAL LINE MODE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Do `M-x toggle-truncate-lines` to jump in and out of truncation mode.

(setq
 ;; NOTE: Line truncation has to be enabled for the visual-line-mode to be effective
 ;; But here you see that truncation is disabled by default. It is enabled
 ;; ONLY in specific modes in which the fci-mode is enabled (setup-fci.el)
 truncate-lines nil ;; enable line wrapping. This setting does NOT apply to windows split using `C-x 3`
 truncate-partial-width-windows nil ;; enable line wrapping in windows split using `C-x 3`
 visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow) ;; Turn on line wrapping fringe indicators in Visual Line Mode
 )

;; (global-visual-line-mode 1) ;; Enable wrapping lines at word boundaries
(global-visual-line-mode -1) ;; Disable wrapping lines at word boundaries

;; Enable/Disable visual-line mode in specific major modes. Enabling visual
;; line mode does word wrapping only at word boundaries
(add-hook 'sh-mode-hook      'turn-off-visual-line-mode) ;; e.g. sim.setup file
(add-hook 'org-mode-hook     'turn-on-visual-line-mode)
(add-hook 'markdown-mode-hook 'turn-on-visual-line-mode)

(defun turn-off-visual-line-mode ()
  (interactive)
  (visual-line-mode -1))

(defun turn-on-visual-line-mode ()
  (interactive)
  (visual-line-mode 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; CURSOR
;; Change cursor color according to mode: read-only buffer / overwrite /
;; regular (insert) mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(blink-cursor-mode -1) ;; Don't blink the cursor, it's distracting!

(defvar hcz-set-cursor-color-color "")
(defvar hcz-set-cursor-color-buffer "")
(defun hcz-set-cursor-color-according-to-mode ()
  "change cursor color according to some minor modes."
  ;; set-cursor-color is somewhat costly, so we only call it when needed:
  (let ((color
         (if buffer-read-only
             ;; Color when the buffer is read-only
             (progn (if dark-theme "yellow" "dark orange"))
           ;; Color when the buffer is writeable but overwrite mode is on
           (if overwrite-mode "red"
             ;; Color when the buffer is writeable but overwrite mode if off
             (if dark-theme "white" "#626262")))))
    (unless (and
             (string= color hcz-set-cursor-color-color)
             (string= (buffer-name) hcz-set-cursor-color-buffer))
      (set-cursor-color (setq hcz-set-cursor-color-color color))
      (setq hcz-set-cursor-color-buffer (buffer-name)))))

(add-hook 'post-command-hook 'hcz-set-cursor-color-according-to-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Presentation mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;cef 8/3/2017 (setq presentation-mode-enabled nil)
;;cef 8/3/2017 
;;cef 8/3/2017 (defun presentation-mode ()
;;cef 8/3/2017   "Set frame size, theme and fonts suitable for presentation."
;;cef 8/3/2017   (interactive)
;;cef 8/3/2017   (setq font-size-pt 13)
;;cef 8/3/2017   (set-face-attribute 'default nil :height (* font-size-pt 10))
;;cef 8/3/2017   (set-frame-position (selected-frame) 0 0) ;; pixels x y from upper left
;;cef 8/3/2017   (set-frame-size (selected-frame) 80 25)  ;; rows and columns w h
;;cef 8/3/2017   (funcall default-light-theme) ;; change to default light theme
;;cef 8/3/2017   (delete-other-windows)
;;cef 8/3/2017   (setq presentation-mode-enabled t)
;;cef 8/3/2017   )
;;cef 8/3/2017 
;;cef 8/3/2017 (defun coding-zombie-mode ()
;;cef 8/3/2017   "Revert to default coding mode."
;;cef 8/3/2017   (interactive)
;;cef 8/3/2017   (setq font-size-pt default-font-size-pt)
;;cef 8/3/2017   (set-face-attribute 'default nil :height (* font-size-pt 10))
;;cef 8/3/2017   (full-screen-right)
;;cef 8/3/2017   (funcall default-theme) ;; change to default theme
;;cef 8/3/2017   (split-window-right)
;;cef 8/3/2017   (setq presentation-mode-enabled nil)
;;cef 8/3/2017   )
;;cef 8/3/2017 
;;cef 8/3/2017 (defun toggle-presentation-mode ()
;;cef 8/3/2017   "Toggle between presentation and default mode."
;;cef 8/3/2017   (interactive)
;;cef 8/3/2017   (if presentation-mode-enabled
;;cef 8/3/2017       (coding-zombie-mode)
;;cef 8/3/2017     (presentation-mode)))
;;cef 8/3/2017 
;;cef 8/3/2017 ;; Coloring regions that have ANSI color codes in them
;;cef 8/3/2017 ;; http://unix.stackexchange.com/questions/19494/how-to-colorize-text-in-emacs
;;cef 8/3/2017 (defun ansi-color-apply-on-region-int (beg end)
;;cef 8/3/2017   "Colorize using the ANSI color codes."
;;cef 8/3/2017   (interactive "r")
;;cef 8/3/2017   (ansi-color-apply-on-region beg end))


(setq setup-visual-loaded t)
(provide 'setup-visual)
