;;; poporg-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (poporg-edit-exit poporg-dwim) "poporg" "poporg.el"
;;;;;;  (21574 54051 509994 0))
;;; Generated autoloads from poporg.el

(autoload 'poporg-dwim "poporg" "\
Single overall command for poporg (a single keybinding may do it all).

If the current buffer is an edit buffer, run `poporg-edit-exit'.

If the region is active, edit it in an empty buffer.  Otherwise, find a nearby
string or comment using `poporg-find-string-or-comment' and edit that in an
empty buffer.  If there is an active edit nearby, pop to its other buffer and
edit that instead.

\(fn)" t nil)

(autoload 'poporg-edit-exit "poporg" "\
Exit the edit buffer, replacing the original region.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("poporg-pkg.el") (21574 54051 529178 321000))

;;;***

(provide 'poporg-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; poporg-autoloads.el ends here
