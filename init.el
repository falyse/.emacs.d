;; Time-stamp: <2017-11-13 10:12:36 cfricano>
;; Original Author: Kaushal Modi
;; Modified By: Courtney Schmitt

;; Record the start time

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(defvar *emacs-load-start* (current-time))

;; Global variables (symbols)
(setq user-home-directory  (getenv "HOME")
      user-emacs-directory (concat user-home-directory "/.emacs.d")
      org-directory        (concat user-home-directory "/org")
      setup-packages-file  (expand-file-name "setup-packages.el" user-emacs-directory)
      custom-file          (expand-file-name "custom.el" user-emacs-directory))

;; Define packages that will be automatically downloaded from MELPA
(defvar my-packages
  '(
    ace-jump-mode  ;; Jump cursor to location based on head character (C-c SPC)
    ace-jump-buffer  ;; ace-jump for buffers
    ace-window
    anzu ;; shows total search hits in mode line, better query-replace alternative
    auto-complete fuzzy  ;; Auto complete typing with fuzzy matching
    auto-highlight-symbol
    benchmark-init
    color-theme-sanityinc-solarized  ;; Solarized color themes
    color-theme-sanityinc-tomorrow   ;; Tomorrow color themes
    dired+ dired-single  ;; Better dired mode
    drag-stuff  ;; Drag lines with C-S-arrow keys, Duplicate with C-S-d
    elfeed ;; Feed reader
    escreen  ;; Screen management for multiple sessions
    expand-region  ;; Expand selected region around cursor (C-=)
    fill-column-indicator  ;; Add markers in emacs to indicate were the fill column occurs
    fiplr ;; quick file search in a project (marked by folders like .git)
    flycheck  ;; on the fly code compiling
    ;flymake  ;; on the fly code compiling
    fold-dwim  ;; code folding
    goto-last-change  ;; jump to last edit position
    guide-key  ;; Display prompts for key bindings specified in setup-guide-key.el
    hardcore-mode  ;; Disable arrow keys and display emacs key bindings instead
    header2  ;; Auto-insert and auto-update headers as defined in setup-header2.el
    helm helm-swoop  ;; Show search results in new buffer (M-i)
    highlight-symbol  ;; Highlight/search word under cursor
    hl-line+  ;; Highlight current line after idle period
    ido-vertical-mode flx-ido  ;; Display buffer messages vertically
    load-theme-buffer-local  ;; Set background color per buffer
    log4j-mode  ;; Line coloring and filtering for log files
    markdown-mode  ;; Markdown syntax mode
    multiple-cursors  ;; Visually edit multiple cursors at once
    multi-eshell  ;; Better management of multiple shells
    multi-term  ;; Better management of multiple terminals
    org ;; Get the latest org-mode package from Melpa
    popwin ;; Open windows like *Help*, *Completions*, etc in minibuffer
    pretty-mode ;; Replace some text with equivalent symbols
    projectile  ;; Project management
    rainbow-delimiters  ;; Highlight nested parens in a different color by depth
    rainbow-mode  ;; Show color names as the color they represent
    shell-switcher  ;; Better management of multiple shells
    smart-compile  ;; Compile for C programs
    smart-mode-line  ;; Customize emacs mode line
    smart-parens  ;; Easier parentheses navigation
    smex ;; smart M-x - Supply frequently and recently used commands
    soft-stone-theme  ;; Soft stone color theme
    stripe-buffer  ;; Use different background colors for even/odd lines in dired mode
    visual-regexp  ;; Visual feedback for regexp (C-c r / C-c q)
    workgroups2  ;; Workspace management
    yafolding ;; indentation detected code folding
    yasnippet
    zenburn-theme  ;; Zenburn color theme
    )
  "A list of packages to ensure are installed at launch.")

(load custom-file) ;; Load the emacs `M-x customize` generated file
(load setup-packages-file) ;; Load the packages

(require 'benchmark-init)
;;(require 'req-package)

;; Set up the looks of emacs including color theme
(require 'setup-visual)

;; Set up extensions/packages
;;cef 12/3/2014 (eval-after-load 'ido '(require 'setup-ido))
;;cef 8/3/2017 (require 'setup-ace-jump-mode)  ;; ace-jump-mode
;;cef 8/3/2017 (require 'setup-auto-complete)  ;; auto-complete
;;cef 8/3/2017 (require 'setup-dired)  ;; diredx, dired+, dired-single
;;cef 8/3/2017 (require 'setup-drag-stuff)  ;; drag-stuff
;(require 'setup-escreen)  ;; escreen
;;cef 8/3/2017 (require 'setup-elfeed)  ;; elfeed
;;cef 8/3/2017 (require 'setup-expand-region)  ;; expand-region
;;ces (require 'setup-fci)  ;; fill-column-indicator
;;cef 8/3/2017 (require 'setup-fiplr)  ;; fiplr
(require 'setup-guide-key)  ;; guide-key
;;ces (require 'setup-hardcore)  ;; hardcore-mode
;;ces (require 'setup-header2)  ;; header2
(require 'setup-helm)  ;; helm
(require 'setup-highlight)  ;; highlight-symbol, highlight-global
;;ces (require 'setup-hl-line+)  ;; hl-line+
(require 'setup-linum)  ;; line-num left
;;ces (require 'setup-multiple-cursors)  ;; multiple-cursors
(require 'setup-org)  ;; org
(require 'setup-popwin)  ;; popwin
;;(require 'setup-pretty-mode)  ;; pretty-mode
;;cef 8/3/2017 (require 'setup-projectile)  ;; projectile
;;ces (require 'setup-server)  ;; emacs server  ;; ces using emacs --daemon instead
;;ces (require 'setup-smart-compile)  ;; smart-compile
(require 'setup-smart-mode-line)  ;; smart-mode-line
(require 'setup-smex)  ;; smex
(require 'setup-stripe-buffer)  ;; stripe-buffer
(require 'setup-yafolding)
;;cef (require 'setup-yasnippet)  ;; yasnippet
(require 'setup-log)

;; Languages
(require 'setup-verilog)
(require 'setup-perl)
;;ces (require 'setup-python)
;;ces (require 'setup-matlab)
;;ces (require 'setup-markdown)
;; (require 'setup-latex)
;; (require 'setup-tcl)
;; (require 'setup-hspice)

;; custom packages
(require 'setup-sos)
(require 'setup-windows-buffers)  ;; winner-mode, uniquify, recentf, window size
(require 'setup-editing)  ;; time stamps, duplicate line, whitespace, toggle comment
(require 'setup-search)  ;; search symbol
;;ces (require 'setup-occur)  ;; occur-mode - search for regexp in buffer(s) (F6)
;;ces (require 'setup-print)  ;; printing  ;; ces - something about this package breaks emacs --daemon
;;ces (require 'setup-desktop)  ;; desktop session save/restore
(require 'setup-misc)
(require 'setup-shell)  ;; ces - customize built in shell to behave more like actual terminal
(require 'setup-registers)
(require 'setup-flymake)


;; NOTE: Load below ONLY after loading all the packages
;;cef 12/3/2014 (require 'setup-workgroups)  ;; workgroups2
(require 'setup-key-bindings)

;; Load the default theme
;;(funcall default-theme)
;;(funcall 'full-screen-right)

(setq emacs-initialized t)

;; Write out a message indicating how long it took to process the init script
(message "init.el loaded in %ds"
         (destructuring-bind (hi lo ms ps) (current-time)
           (- (+ hi lo)
              (+ (first *emacs-load-start*)
                 (second *emacs-load-start*)))))
