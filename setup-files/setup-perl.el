;; Time-stamp: <2017-11-20 09:49:56 cfricano>

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
(defun perl-indent-normal()
  (interactive)
  (setq cperl-indent-level 4)
  (setq cperl-brace-offset 0)
  (setq cperl-continued-brace-offset -4)
  (setq cperl-label-offset -4)
  (setq cperl-continued-statement-offset 4))

(defun perl-indent-small()
  (interactive)
  (setq cperl-indent-level 2)
  (setq cperl-brace-offset 0)
  (setq cperl-continued-brace-offset -2)
  (setq cperl-label-offset -2)
  (setq cperl-continued-statement-offset 2))

(perl-indent-normal)
  
;                                    K&R BSD=C++ GNU PerlStyle=Whitesmith
;  cperl-indent-level                5   4       2   4
;  cperl-brace-offset                0   0       0   0
;  cperl-continued-brace-offset     -5  -4       0   0
;  cperl-label-offset               -5  -4      -2  -4
;  cperl-continued-statement-offset  5   4       2   4



; Outline minor mode
;(require 'outshine)
;(add-hook 'outline-minor-mode-hook 'outshine-hook-function)
;(defmacro join (join-char &rest others) `(mapconcat 'identity ',others ,join-char))
;(setq my-cperl-outline-regexp
;      (concat
;       "^"                              ; Start of line
;       "[ \\t]*"                        ; Skip leading whitespace
;       "\\("                            ; begin capture group \1
;       (join "\\|"
;             "=head[12]"                  ; POD header
;             "package"                    ; package
;             "=item"                      ; POD item
;             "sub"                        ; subroutine definition
;           )
;       "\\)"                            ; end capture group \1
;       "\\b"                            ; Word boundary
;       ))

; Hide-Show minor mode
;(add-hook 'cperl-mode-hook       'hs-minor-mode)
;(require 'fold-dwim)

; Dumb-jump - TODO move elsewhere
;(setq dumb-jump-default-project "~/adsim_dev/adsim")
;(setq dumb-jump-force-searcher 'ag)
(setq dumb-jump-selector 'helm)

; Display containing function in mode line
(which-function-mode 1)

; Superword minor mode
(add-hook 'cperl-mode-hook       'superword-mode)

(provide 'setup-perl)
