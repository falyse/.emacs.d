;; Time-stamp: <2017-12-13 19:51:08 cfricano>

;;cef ;; smart-mode-line
;;cef ;; emacs modeline aka statusbar
;;cef ;; Source: https://github.com/Bruce-Connor/smart-mode-line
;;cef 
;;cef ;; It is crucial that this require line happens after the above setq block
;;cef (require 'smart-mode-line)
;;cef 
;;cef (setq ;cef sml/theme 'dark
;;cef       sml/name-width 40 ;; space allocated for the buffer name in the mode-line
;;cef       sml/line-number-format "%4l"
;;cef       sml/mode-width 'full
;;cef       ;cef sml/replacer-regexp-list
;;cef       ;cef '(
;;cef       ;cef   ("^~/org/" ":Org:")
;;cef       ;cef   ("^~/\\.emacs\\.d/" ":ED:")
;;cef       ;cef   ;; Prefix with first 2 letters and last letter of project name
;;cef       ;cef   ;; To distinguish between projects that could have same first 3 letters
;;cef       ;cef   ;; Using "\,(upcase ...)" only works when calling `replace-regexp` interactively.
;;cef       ;cef   ;; In lisp code you have to give it a function. So we need to change the
;;cef       ;cef   ;; replacement string to,
;;cef       ;cef   ;; `(lambda (string) (concat ":" (upcase (match-string 1 string)) ":")))`.
;;cef       ;cef   ("/projects/\\([a-z0-9_]\\{2\\}\\).*?\\([a-z0-9_]\\)/.+?/digital[_db]*/"
;;cef       ;cef    (lambda (string) (concat ":"
;;cef       ;cef                             (capitalize (match-string 1 string))
;;cef       ;cef                             (upcase (match-string 2 string))
;;cef       ;cef                             ":DIG:") ) )
;;cef       ;cef   (":\\(.*\\):DIG:tb/"                        ":\\1:TB:" )
;;cef       ;cef   (":\\(.*\\):TB:uvm/"                        ":\\1:UVM:" )
;;cef       ;cef   (":\\(.*\\):TB:patterns/"                   ":\\1:PAT:" )
;;cef       ;cef   (":\\(.*\\):DIG:design_code/"               ":\\1:DSGN:")
;;cef       ;cef   (":\\(.*\\):DSGN:rtl/"                      ":\\1:RTL:" )
;;cef       ;cef   (":\\(.*\\):DSGN:analog_partition_rtl/"     ":\\1:ANA:" )
;;cef       ;cef   (":\\(.*\\):DSGN:yoda/"                     ":\\1:YODA:")
;;cef       ;cef   )
;;cef       display-time-format "%l:%M %b %d %a" ;; customize the date and time display format in mode-line
;;cef       ;; Variables used in display-time-format
;;cef       ;; Source: http://docs.splunk.com/Documentation/Splunk/5.0.2/SearchReference/Commontimeformatvariables
;;cef       ;; %y = year in numbers (2-digit)
;;cef       ;; %Y = year in numbers (4-digit)
;;cef       ;; %m = month in number (eg: 12)
;;cef       ;; %B = full month name (eg: December)
;;cef       ;; %b = short month name (eg: Dec)
;;cef       ;; %d = day in numbers, with leading zeros (eg: 08)
;;cef       ;; %e = day in numbers, no leading zeros (eg: 8)
;;cef       ;; %A = full weekday name (eg: Sunday)
;;cef       ;; %a = short weekday name (eg: Sun)
;;cef       ;; %H = hours in 24-clock, with leading zeros
;;cef       ;; %k = hours in 24-clock, no leading zeros
;;cef       ;; %l = hours in 12-clock, with leading zeros
;;cef       ;; %p = am/pm
;;cef       ;; %T = time in 24-hour notation (%H:%M:%S)
;;cef       display-time-default-load-average nil ;; do NOT show average system load time
;;cef       line-number-mode t ;; show line # in mode-line
;;cef       column-number-mode t ;; show column # in mode-line
;;cef       )
;;cef 
;;cef     (setq rm-blacklist
;;cef           '(" Guide"     ;; guide-key mode
;;cef             " hc"        ;; hardcore mode
;;cef             " AC"        ;; auto-complete
;;cef             " vl"        ;; global visual line mode enabled
;;cef             " Wrap"      ;; shows up if visual-line-mode is enabled for that buffer
;;cef             " Omit"      ;; omit mode in dired
;;cef             " yas"       ;; yasnippet
;;cef             " drag"      ;; drag-stuff-mode
;;cef             " VHl"       ;; volatile highlights
;;cef             " ctagsU"    ;; ctags update
;;cef             " Undo-Tree" ;; undo tree
;;cef             " wr"        ;; Wrap Region
;;cef             " SliNav"    ;; elisp-slime-nav
;;cef             " Fly"       ;; Flycheck
;;cef             " PgLn"      ;; page-line-break
;;cef             " GG"        ;; ggtags
;;cef             "Helm"      ;; helm
;;cef             ))
;;cef 
;;cef ;; cef override default abbreviations
;;cef (add-to-list 'sml/replacer-regexp-list '())
;;cef 
;;cef ;; Load sml with above configuration
;;cef (sml/setup)
;;cef 
;;cef ;; http://bruce-connor.github.io/emacs-online-documentation/Var/display-time-mode
;;cef ;; Just setting display-time-mode to "t" does not work. You have to manually call
;;cef ;; the display-time-mode function if display-time-mode is not set to t via
;;cef ;; `M-x customize`
;;cef (display-time-mode 1)
;;cef 
;;cef 
;;cef ;; powerline
;;cef (require 'powerline)
;;cef (powerline-default-theme)




; spaceline
(require 'spaceline-config)
(spaceline-spacemacs-theme)
(spaceline-toggle-buffer-size-off)
(spaceline-toggle-buffer-encoding-abbrev-off)


; diminish to reduce minor mode text
(require 'diminish)
(diminish 'helm-mode)
(diminish 'volatile-highlights-mode)
(eval-after-load "flycheck" '(diminish 'flycheck-mode))
(eval-after-load "superword" '(diminish 'superword-mode))
(diminish 'smartparens-mode)
(diminish 'auto-revert-mode)
(diminish 'which-key-mode)

(setq setup-smart-mode-line-loaded t)
(provide 'setup-smart-mode-line)
