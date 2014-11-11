;; Time-stamp: <2014-10-27 16:04:10 cfricano>

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


(defun my-verilog-mode-customizations()
  ;; Unbind the backtick binding done to `electric-verilog-tick'
  ;; With binding done to electric-verilog-tick, it's not possible to type
  ;; backticks on multiple lines simultaneously in multiple-cursors mode
  (define-key verilog-mode-map "\`"          nil)
  (define-key verilog-mode-map (kbd "C-c d") 'my-verilog-insert-date)
  ;; Replace tabs with spaces when saving files in verilog-mode
  ;; Source: http://www.veripool.org/issues/345-Verilog-mode-can-t-get-untabify-on-save-to-work
  ;; Note that keeping that `nil' in the argument is crucial; otherwise emacs
  ;; with stay stuck with the "Saving file .." message and the file won't be
  ;; saved.
  ;;(add-hook 'local-write-file-hooks
  ;;          (lambda() (untabify (point-min) (point-max)) nil))

  ;; Source: http://emacs-fu.blogspot.com/2008/12/highlighting-todo-fixme-and-friends.html
  (font-lock-add-keywords nil
                          '(("\\b\\(FIXME\\|TODO\\|BUG\\)\\b" 1
                             font-lock-warning-face t)))
  ;; Above solution highlights those keywords anywhere in the buffer (not just
  ;; in comments). To do the highlighting intelligently, install the fic-mode
  ;; package -- http://www.emacswiki.org/emacs/fci-mode.el
  )
(add-hook 'verilog-mode-hook 'my-verilog-mode-customizations)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Macros saved as functions
;;
;; Regex Search Expression - \$display(\(.*?\));\(.*\)
;; Replace Expression - `uvm_info("REPLACE_THIS_GENERIC_ID", $sformatf(\1), UVM_MEDIUM) \2
(fset 'uvm-convert-display-to-uvm_info
      (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([3 113 92 36 100 105 115 112 108 97 121 40 92 40 46 42 63 92 41 41 59 92 40 46 42 92 41 return 96 117 118 109 95 105 110 102 111 40 34 82 69 80 76 65 67 69 95 84 72 73 83 95 71 69 78 69 82 73 67 95 73 68 34 44 32 36 115 102 111 114 109 97 116 102 40 92 49 41 44 32 85 86 77 95 77 69 68 73 85 77 41 32 92 50 return 33] 0 "%d")) arg)))
;;

(setq setup-verilog-loaded t)
(provide 'setup-verilog)
