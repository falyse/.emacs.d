;; Time-stamp: <2014-10-24 09:37:49 cfricano>

;;Python

(require 'python-mode)

;; ; use IPython
;; (setq-default py-shell-name "ipython")
;; (setq-default py-which-bufname "IPython")
; use python3
;; ; use the wx backend, for both mayavi and matplotlib
;; (setq py-python-command-args
;;   '("--gui=wx" "--pylab=wx" "-colors" "Linux"))
;; (setq-default py-shell-name "python3")
;; (setq-default py-which-bufname "Python3")
(setq py-force-py-shell-name-p t)
; switch to the interpreter after executing code
(setq py-shell-switch-buffers-on-execute-p t)
; don't switch the code buffer to python shell
(setq py-switch-buffers-on-execute-p nil)
; split windows
(setq py-split-windows-on-execute-p t)
; try to automagically figure out indentation
(setq py-smart-indentation t)

(provide 'setup-python)
