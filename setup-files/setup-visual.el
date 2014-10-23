;; Time-stamp: <2014-06-18 11:02:01 cschmitt>

;; Set up the looks of emacs

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

;; zenburn
(defun zenburn ()
  "Activate zenburn theme."
  (interactive)
  (setq dark-theme t)
  (setq light-theme nil)
  ;; disable other themes before setting this theme
  (disable-theme 'sanityinc-solarized-dark)
  (disable-theme 'sanityinc-solarized-light)
  (disable-theme 'sanityinc-tomorrow-blue)
  (disable-theme 'soft-stone)
  (load-theme    'zenburn t))

;; soft-stone
(defun light ()
  "Activate soft-stone theme."
  (interactive)
  (setq dark-theme nil)
  (setq light-theme t)
  ;; disable other themes before setting this theme
  (disable-theme 'zenburn)
  (disable-theme 'sanityinc-solarized-light)
  (disable-theme 'sanityinc-solarized-dark)
  (disable-theme 'sanityinc-tomorrow-blue)
  (load-theme    'soft-stone)
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "red" :weight bold)
                ("NEXT" :foreground "blue" :weight bold)
                ("DONE" :foreground "forest green" :weight bold)
                ("WAITING" :foreground "orange" :weight bold)
                ("HOLD" :foreground "burlywood" :weight bold)
                ("CANCELED" :foreground "forest green" :weight bold))))
  ;; (setq ansi-color-names-vector
        ;; ["black" "red" "ForestGreen" "gold1" "blue" "MediumOrchid1" "RoyalBlue" "white"])
  ;; (when (fboundp 'ansi-color-make-color-map)
      ;; (setq ansi-color-map (ansi-color-make-color-map)))
  )

;; tomorrow-blue
(defun dark ()
  "Activate tomorrow-blue theme."
  (interactive)
  (setq dark-theme t)
  (setq light-theme nil)
  ;; disable other themes before setting this theme
  (disable-theme 'zenburn)
  (disable-theme 'sanityinc-solarized-light)
  (disable-theme 'sanityinc-solarized-dark)
  (disable-theme 'soft-stone)
  (load-theme    'sanityinc-tomorrow-blue)
  (setq org-todo-keyword-faces
        (quote (("TODO" :foreground "salmon" :weight bold)
                ("NEXT" :foreground "deepskyblue" :weight bold)
                ("DONE" :foreground "pale green" :weight bold)
                ("WAITING" :foreground "lightgoldenrod" :weight bold)
                ("HOLD" :foreground "burlywood" :weight bold)
                ("CANCELED" :foreground "pale green" :weight bold))))
;;  ;; (setq ansi-color-names-vector
;;        ;; ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white"])
;;  ;; (setq ansi-color-map (ansi-color-make-color-map)) 
  )

(setq global-font-lock-mode t ;; enable font-lock or syntax highlighting globally
      font-lock-maximum-decoration t ;; use the maximum decoration level available for color highlighting
      )

;; Set the color theme
;(dark)  ;; Use dark theme
(light)  ;; Use light theme

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Rainbow parens
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)  ;; enable in all programming modes

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Different background for shells
(add-hook 'shell-mode-hook (lambda nil
   (load-theme-buffer-local 'dichromacy (current-buffer))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FONT SIZE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; set the font size specified in default-font-size-pt symbol
(setq font-size-pt default-font-size-pt)
;; The internal font size value is 10x the font size in points unit.
;; So a 10pt font size is equal to 100 in internal font size value.
(set-face-attribute 'default nil :height (* font-size-pt 10))

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
         (if buffer-read-only "yellow"
           (if overwrite-mode "red"
             (if dark-theme "white" "dark orange")))))
    (unless (and
             (string= color hcz-set-cursor-color-color)
             (string= (buffer-name) hcz-set-cursor-color-buffer))
      (set-cursor-color (setq hcz-set-cursor-color-color color))
      (setq hcz-set-cursor-color-buffer (buffer-name)))))

(add-hook 'post-command-hook 'hcz-set-cursor-color-according-to-mode)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Frame title bar format
;; If buffer-file-name exists, show it;
;; else if you are in dired mode, show the directory name
;; else show only the buffer name (*scratch*, *Messages*, etc)
;; Append the value of PRJ_NAME env var to the above.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq project-name (getenv "PRJ_NAME"))
(setq frame-title-format
      (list '(buffer-file-name "%f"
                               (dired-directory dired-directory "%b"))
            " [" project-name "]"))


(setq setup-visual-loaded t)
(provide 'setup-visual)
