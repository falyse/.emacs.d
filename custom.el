;; Do NOT manually edit the below custom-set-variables block
;; Comments added manually in above custom-set-variables block are not
;; retained. To add comments, do `M-x customize` search for that variable, click
;; on State button for that variable and click on "Add comment". After doing
;; that, click on State button once again and click on "Save for future sessions".
;; *Manually added comments get deleted when emacs updates this block.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-ignores (quote ("/" "//" "/*" "//*" "///" "////")) t)
 '(ac-stop-words (quote ("/" "//" "/*" "//*" "///" "////")) t)
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#ffffff" "tomato" "lime green" "gold1" "blue" "MediumOrchid1" "deep sky blue" "#002451"])
 '(auto-compression-mode t nil (jka-compr) "uncompress->edit->save->compress .gz, .bz2, .Z files on the fly")
 '(blink-cursor-mode nil)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks" t)
 '(case-fold-search t nil nil "ignore case when searching; searching using an all-lowercase string will match the same strings with uppercase characters too")
 '(column-number-mode t)
 '(comint-buffer-maximum-size 10000)
 '(comint-completion-addsuffix t)
 '(comint-get-old-input (lambda nil "") t)
 '(comint-input-ignoredups t)
 '(comint-input-ring-size 5000)
 '(comint-move-point-for-output nil)
 '(comint-prompt-read-only nil)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input t)
 '(custom-safe-themes
   (quote
    ("3b5ce826b9c9f455b7c4c8bff22c020779383a12f2f57bf2eb25139244bb7290" "15348febfa2266c4def59a08ef2846f6032c0797f001d7b9148f30ace0d08bcf" "d9a09bb02e2a1c54869dfd6a1412553fe5cb2d01a94ba25ef2be4634d1ca2c79" "282606e51ef2811142af5068bd6694b7cf643b27d63666868bc97d04422318c1" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "6a37be365d1d95fad2f4d185e51928c789ef7a4ccf17e7ca13ad63a8bf5b922f" "1011be33e9843afd22d8d26b031fbbb59036b1ce537d0b250347c19e1bd959d0" "bbd99b10462e3d0f4ac6da09e23e5de1fed4f7fe87d679a6468a14b0b6c8e634" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "b1a6b113840c7f739ccf2a330f28dd8f9f29a37081312a3f00845fd4ba3f3489" "9370aeac615012366188359cb05011aea721c73e1cb194798bc18576025cabeb" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "f3ceb7a30f6501c1093bc8ffdf755fe5ddff3a85437deebf3ee8d7bed8991711" "5f7580488c9eb32997d0cd29ab1720c944cdf76d543a860588c733cead175e15" "8eef22cd6c122530722104b7c82bc8cdbb690a4ccdd95c5ceec4f3efa5d654f5" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "f3d2144fed1adb27794a45e61166e98820ab0bbf3cc7ea708e4bf4b57447ee27" "a2c537c981b4419aa3decac8e565868217fc2995b74e1685c5ff8c6d77b198d6" "31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" default)))
 '(default-input-method "rfc1345")
 '(delete-selection-mode t nil nil "typing anything after highlighting text overwrites that text; source: http://emacsredux.com/blog/2013/04/12/delete-selection-on-insert/")
 '(display-time-mode t)
 '(doc-view-continuous t)
 '(fci-rule-color "dim gray" t)
 '(fringe-mode nil nil (fringe))
 '(indent-tabs-mode nil nil nil "use spaces instead of tabs for indentation")
 '(indicate-buffer-boundaries (quote ((top . right) (bottom . right))) nil nil "show frame boundaries in the fringe; as the fringe is activated only for the right-hand side, the buffer boundaries (top, bottom) are marked on the right side")
 '(inhibit-startup-screen t)
 '(keyboard-coding-system (quote utf-8-unix) nil nil "default EOL system = that of Unix")
 '(major-mode (quote text-mode) nil nil "If the default value of major-mode is nil, the major mode is taken from the previously current buffer")
 '(next-line-add-newlines nil nil nil "Do not auto-add newlines at the end of the file on pressing `C-n` or down arrow")
 '(package-selected-packages
   (quote
    (org-super-agenda term-projectile which-key diminish spaceline persp-projectile perspective helm-projectile paradox smart-parens zenburn-theme yasnippet yaml-mode yafolding xkcd wrap-region workgroups2 wgrep-ag web-mode w3m volatile-highlights visual-regexp undo-tree swoop stripe-buffer soft-stone-theme smex smartparens smart-mode-line smart-compile shell-switcher req-package region-bindings-mode rainbow-mode rainbow-delimiters projectile pretty-mode poporg perlcritic page-break-lines ox-reveal outshine number nlinum names mwe-log-commands multiple-cursors multi-term multi-eshell markdown-mode manage-minor-mode magit log4j-mode load-theme-buffer-local leuven-theme key-chord iy-go-to-char iregister ido-vertical-mode ido-ubiquitous hungry-delete htmlize hl-line+ highlight-symbol helm-swoop header2 hardcore-mode guide-key goto-last-change github-theme ggtags fuzzy fold-dwim flymake-cursor flycheck-color-mode-line flx-ido flatui-theme fiplr fill-column-indicator expand-region escreen elisp-slime-nav elfeed eimp dumb-jump drag-stuff discover-my-major discover dired-single dired+ csv-nav color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized cmake-mode buffer-move bookmark+ benchmark-init auto-highlight-symbol auto-complete auctex anzu ag ace-window ace-jump-mode ace-jump-buffer)))
 '(paradox-github-token t)
 '(projectile-mode t nil (projectile))
 '(protect-buffer-bury-p nil t)
 '(require-final-newline nil nil nil "Do not auto-add a final newline (if one is not present) when saving/visiting a file")
 '(save-place t nil (saveplace) "save the last cursor location for each file")
 '(select-enable-clipboard t nil nil "after copy Ctrl+c in X11 apps, you can paste by 'yank' in emacs")
 '(select-enable-primary t nil nil "after mouse selection in X11, you can paste by 'yank' in emacs")
 '(show-paren-mode t nil (paren) "allow one to see matching pairs of parentheses; when point is on one of the paired characters, the other is highlighted")
 '(tool-bar-mode nil)
 '(vc-annotate-background "#2B2B2B" t)
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))) t)
 '(vc-annotate-very-old-color "#DC8CC3" t)
 '(visible-bell t nil nil "enable the visible bell or screen blink to happen when there's any error"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 145 :width normal :foundry "misc" :family "fixed"))))
 '(cperl-array-face ((t (:foreground "blue" :weight normal))))
 '(cperl-hash-face ((t (:foreground "red" :weight normal))))
 '(linum ((t (:foreground "dim gray" :slant italic))))
 '(org-level-2 ((t (:inherit outline-2 :foreground "#232323" :weight bold))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "#393939" :weight normal))))
 '(org-warning ((t (:foreground "#ff0000" :underline t)))))
