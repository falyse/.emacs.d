;; Time-stamp: <2014-10-24 08:33:08 cfricano>

;; Matlab

(prepend-path "~/.emacs.d/matlab-emacs")

(require 'matlab-load)

;;(autoload 'matlab-mode "matlab" "Enter Matlab mode." t)
;;(setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))
;;(autoload 'matlab-shell "matlab" "Interactive Matlab mode." t)

(provide 'setup-matlab)
