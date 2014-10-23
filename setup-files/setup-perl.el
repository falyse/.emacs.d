;; Time-stamp: <2014-05-12 10:59:41 cschmitt>

;; Perl

;; Use cperl-mode instead of the default perl-mode
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

;; ces - Cperl mode customizations

;(setq cperl-hairy t) ;; Turns on most of the CPerlMode options
(setq cperl-font-lock t)
;(setq cperl-electric-lbrace-space nil) ;; not: { after $ should be preceded by ` \u2018
(setq cperl-electric-parens nil)  ;; auto close ( with )
;(setq cperl-electric-linefeed t)
(setq cperl-electric-keywords nil)          ;; expands for keywords such as
;(setq cperl-info-on-command-no-prompt t)
;(setq cperl-clobber-lisp-bindings t)
;(setq cperl-lazy-help-time t)

(setq cperl-invalid-face nil)  ;turn off whitespace underline
(setq cperl-highlight-variables-indiscriminately t)  ; always highlight scalars ex. if ($test)

;(setq cperl-auto-newline t)
(setq cperl-extra-newline-before-brace t) ;; foreach, while, etc...
(setq cperl-merge-trailing-else nil) ;; put else on new line after }

(custom-set-faces
 '(cperl-array-face ((t (:foreground "blue" :weight normal))))
 '(cperl-hash-face ((t (:foreground "red" :weight normal))))
; '(cperl-hash-face ((t (:foreground "red" :slant italic :weight normal))))
; '(font-lock-comment-face ((t (:foreground "Coral"))))
; '(font-lock-function-name-face ((t (:foreground "green"))))
 )

; Indentation
(setq cperl-indent-level 4)
(setq cperl-brace-offset 0)
(setq cperl-continued-brace-offset -4)
(setq cperl-label-offset -4)
(setq cperl-continued-statement-offset 4)
;                                    K&R BSD=C++ GNU PerlStyle=Whitesmith
;  cperl-indent-level                5   4       2   4
;  cperl-brace-offset                0   0       0   0
;  cperl-continued-brace-offset     -5  -4       0   0
;  cperl-label-offset               -5  -4      -2  -4
;  cperl-continued-statement-offset  5   4       2   4

(provide 'setup-perl)
