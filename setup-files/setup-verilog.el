;; Time-stamp: <2014-02-05 15:59:35 cschmitt>

;; Verilog

;; Load verilog mode only when needed
(autoload 'verilog-mode "verilog-mode" "Verilog mode" t )
;; Any files that end in .v should be in verilog mode
(setq auto-mode-alist (cons '("\\.v\\'"    . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sv\\'"   . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.svh\\'"  . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.vp\\'"   . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.tv\\'"   . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.psl\\'"  . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.h\\'"    . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.f\\'"    . verilog-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.vinc\\'" . verilog-mode) auto-mode-alist))

;; Replace tabs with spaces when saving files in verilog-mode
;;ces (add-hook 'verilog-mode-hook
;;ces           '(lambda ()
;;ces              (add-hook 'local-write-file-hooks
;;ces                        (lambda()
;;ces                          (untabify (point-min) (point-max))
;;ces                          nil))))

;; ;; Make _ visible to commands like `M-d`, `M-b`, `M-f`, etc
;; (add-hook 'verilog-mode-hook
;;           '(lambda()
;;              ;; Specify the underscore character as a member of emacs’ punctuation class
;;              (modify-syntax-entry ?_ "_")))
;; ** Problem with the above code snippet is that the syntax highlighting gets
;; messed up. In a string like "spi_reg_abc", reg gets highlighted (which shouldn't)

;; Verilog mode customization
(setq verilog-indent-level             3
      verilog-indent-level-module      3
      verilog-indent-level-declaration 3
      verilog-indent-level-behavioral  3
      verilog-indent-level-directive   1
      verilog-case-indent              2
      verilog-auto-indent-on-newline   t
      verilog-tab-always-indent        t
      verilog-minimum-comment-distance 40
      verilog-indent-begin-after-if    t
      verilog-auto-lineup              `(all)
      verilog-align-ifelse             t
      verilog-auto-endcomments         t
      verilog-auto-newline             t
      verilog-tab-to-comment           nil
      )

;; Commented because it doesn't work as of now
;; ;; Code folding
;; ;; always load folding-mode
;; (add-hook 'verilog-mode-hook '(lambda ()
;;                                 (folding-mode)))
;; ;; when running verilog-auto (c-c c-a), unfold first of ports of instantiated modules might not be seen!!!!
;; (add-hook 'verilog-before-auto-hook '(lambda ()
;;                                 (folding-open-buffer)))
;; ;; also for files automatically read in for AUTO expansion
;; (add-hook 'verilog-before-save-font-hook '(lambda ()
;;                                 (folding-open-buffer)))

;; (require 'ffap)
;; (defun ffap-verilog (name)
;;   (let ((inhibit-changing-match-data t) ;; string-match should not change match data
;;         (ppss (syntax-ppss)))
;;     (if (and (eq (syntax-ppss-context ppss) 'comment) ;; we are inside a comment
;;              (= (line-number-at-pos (nth 8 ppss)) (line-number-at-pos (point))) ;; limit the match to the line starting the comment
;;              (string-match "/[/*]\\([[:alnum:]_.]\\)+$"
;;                            (buffer-substring-no-properties (nth 8 ppss) (point))))
;;         ""
;;       name)))
;; (setq ffap-require-prefix t) ;; find file at point
;; (add-to-list 'ffap-alist '(verilog-mode . ffap-verilog) 'append)
;; (define-key global-map (kbd "C-S-x C-S-f") 'find-file-at-point)


(setq setup-verilog-loaded t)
(provide 'setup-verilog)
