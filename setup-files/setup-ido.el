;; Time-stamp: <2014-12-03 10:02:21 cfricano>

;; Interactively Do Things
;; Source: http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;; Source: https://github.com/magnars/.emacs.d/blob/master/setup-ido.el

;; If ido-ubiquitous 1.6 is used in emacs 24.3, there will always be a
;; compile-log buffer warnings; below defvars will prevent those.
(defvar ido-cur-item         nil)
(defvar ido-default-item     nil)
(defvar predicate            nil)
(defvar inherit-input-method nil)
(defvar ido-cur-list         nil)

(require 'ido)
(setq ido-enable-flex-matching t ;; enable fuzzy search
      ido-everywhere t
      ido-create-new-buffer 'always ;; create a new buffer if no buffer matches substring
      ido-file-extensions-order '(".sv" ".v" ".svh" ".tv" ".m" ".c" ".cpp" ".emacs")
      ;;  customize the order in which files are sorted when Ido displays them in
      ;; the minibuffer. There are certain file extensions I use more than others,
      ;; so I tell Ido to emphasize those
      ido-use-filename-at-point 'guess ;; find file at point using ido
      ido-auto-merge-work-directories-length 0 ;; look into other directories if
                       ;; the entered filename doesn't exist in current directory
      ;; ido-auto-merge-work-directories-length -1 ;; do NOT look into other directories if
      ;;                  ;; the entered filename doesn't exist in current directory
      )
(ido-mode 1)

;; (setq ido-enable-prefix nil
;;       ido-case-fold nil
;;       ido-use-filename-at-point nil
;;       ido-max-prospects 10)

;; Use flx-ido for better flex matching between words
(require 'flx-ido)
(flx-ido-mode 1)
(setq ido-use-faces nil) ;; disable ido faces to see flx highlights

;; flx-ido looks better with ido-vertical-mode
(require 'ido-vertical-mode)
(ido-vertical-mode 1)

;; (defun ido-disable-line-truncation ()
;;   (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(defun ido-define-keys ()
  ;; C-n/p  and up/down keys are more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ido-next-match)
  (define-key ido-completion-map (kbd "<down>") 'ido-next-match)
  (define-key ido-completion-map (kbd "C-p") 'ido-prev-match)
  (define-key ido-completion-map (kbd "<up>") 'ido-prev-match))
(add-hook 'ido-setup-hook 'ido-define-keys)

;; ;; Use C-w to go back up a dir to better match normal usage of C-w
;; ;; - insert current file name with C-x C-w instead.
;; (define-key ido-file-completion-map (kbd "C-w") 'ido-delete-backward-updir)
;; (define-key ido-file-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name)

;; (define-key ido-file-dir-completion-map (kbd "C-w") 'ido-delete-backward-updir)
;; (define-key ido-file-dir-completion-map (kbd "C-x C-w") 'ido-copy-current-file-name))

;; ;; Always rescan buffer for imenu
;; (set-default 'imenu-auto-rescan t)

;; ;; Ido at point (C-,)
;; (require 'ido-at-point)
;; (ido-at-point-mode)

;; Use ido everywhere
(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)

;; Sometimes when using ido-switch-buffer the *Messages* buffer get in the way,
;; so we set it to be ignored (it can be accessed using `C-h e', so there is
;; really no need for it in the buffer list).
;; Source: https://github.com/larstvei/dot-emacs
(add-to-list 'ido-ignore-buffers "*Messages*")

;; ;; Fix ido-ubiquitous for newer packages
;; (defmacro ido-ubiquitous-use-new-completing-read (cmd package)
;;   `(eval-after-load ,package
;;      '(defadvice ,cmd (around ido-ubiquitous-new activate)
;;         (let ((ido-ubiquitous-enable-compatibility nil))
;;           ad-do-it))))

;; (ido-ubiquitous-use-new-completing-read webjump 'webjump)
;; (ido-ubiquitous-use-new-completing-read yas-expand 'yasnippet)
;; (ido-ubiquitous-use-new-completing-read yas-visit-snippet-file 'yasnippet)


;; sort ido filelist by mtime instead of alphabetically
;; source: http://www.emacswiki.org/emacs/InteractivelyDoThings
;;cef (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;;cef (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
;;cef (defun ido-sort-mtime ()
;;cef   (setq ido-temp-list
;;cef         (sort ido-temp-list
;;cef               (lambda (a b)
;;cef                 (time-less-p
;;cef                  (sixth (file-attributes (concat ido-current-directory b)))
;;cef                  (sixth (file-attributes (concat ido-current-directory a)))))))
;;cef   (ido-to-end  ;; move . files to end (again)
;;cef    (delq nil (mapcar
;;cef               (lambda (x) (and (char-equal (string-to-char x) ?.) x))
;;cef               ido-temp-list))))


;; Open recent files with IDO,
;; https://github.com/lunaryorn/stante-pede/blob/master/init.el
;; http://emacsredux.com/blog/2013/04/05/recently-visited-files/
;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/cgc8f6b
;; `abbreviate-file-name' abbreviates home dir to ~/ in the file list
;; Custom abbreviations can be added to `directory-abbrev-alist'.
(require 'recentf)
(defun ido-find-recentf ()
  "Use ido to select a recently opened file from the `recentf-list'"
  (interactive)
  (find-file
   (ido-completing-read "Recentf open: "
                        (mapcar 'abbreviate-file-name recentf-list)
                        nil t)))


;; Be able to bury buffers from ido
;; Source: http://endlessparentheses.com/Ido-Bury-Buffer.html
(defun endless/ido-bury-buffer-at-head ()
  "Bury the buffer at the head of `ido-matches'."
  (interactive)
  (let ((enable-recursive-minibuffers t)
        (buf (ido-name (car ido-matches)))
        (nextbuf (cadr ido-matches)))
    (when (get-buffer buf)
      ;; If next match names a buffer use the buffer object;
      ;; buffer name may be changed by packages such as
      ;; uniquify.
      (when (and nextbuf (get-buffer nextbuf))
        (setq nextbuf (get-buffer nextbuf)))
      (bury-buffer buf)
      (if (bufferp nextbuf)
          (setq nextbuf (buffer-name nextbuf)))
      (setq ido-default-item nextbuf
            ido-text-init ido-text
            ido-exit 'refresh)
      (exit-minibuffer))))


(setq setup-ido-loaded t)
(provide 'setup-ido)
