;; Time-stamp: <2016-11-14 06:27:59 cfricano>

;; Org Mode

(setq org-directory "~/org")

(setq org-log-done 'timestamp) ;; Insert only timestamp when closing an org TODO item
;; (setq org-log-done 'note) ;; Insert timestamp and note when closing an org TODO item
;; Source:http://orgmode.org/manual/Closing-items.html
;; (setq org-startup-indented t) ;; indented headers
;;ces (setq org-hide-leading-stars t) ;; hidden leading stars
;;ces (setq org-agenda-files (concat org-directory "/agenda.files"))  ;; ces for some reason this fails
;;ces (setq org-blank-before-new-entry (quote ((heading) (plain-list-item)))) ;; prevent auto blank lines
(setq org-blank-before-new-entry nil) ;; prevent auto blank lines
(setq org-completion-use-ido t) ;; use ido for auto completion
(setq org-return-follows-link t) ;; Hitting <RET> while on a link follows the link
(setq org-startup-folded (quote showeverything))
;; TODO
;;ces (setq org-todo-keywords (quote ((sequence "TODO" "SOMEDAY" "DONE"))))
(setq org-enforce-todo-dependencies t) ;; block entries from changing state to DONE
                          ;; while they have children that are not DONE
                          ;; Source: http://orgmode.org/manual/TODO-dependencies.html

(setq org-agenda-archives-mode nil ;; required in org 8.0+
      org-agenda-skip-comment-trees nil
      org-agenda-skip-function nil
      org-src-fontify-natively t ;; fontify code in code blocks
      org-pretty-entities t ;; Display entities like \tilde, \alpha, etc in UTF-8 characters
      org-pretty-entities-include-sub-superscripts nil ;; Display entities like \tilde, \alpha, etc in UTF-8 characters
      org-export-with-smart-quotes t
      ;; active single key command execution when at beginning of a headline
      org-use-speed-commands t
      ;; Allow _ and ^ characters to sub/super-script strings but only when followed by braces
      org-use-sub-superscripts         '{}
      org-export-with-sub-superscripts '{}
      org-completion-use-ido t ;; use ido for auto completion
      org-return-follows-link t ;; Hitting <RET> while on a link follows the link
      )

;; change the default app for opening pdf files from org
;; Source: http://stackoverflow.com/questions/8834633/how-do-i-make-org-mode-open-pdf-files-in-evince
(eval-after-load "org"
  '(progn
     (add-to-list 'org-src-lang-modes '("systemverilog" . verilog))
     (add-to-list 'org-src-lang-modes '("dot"           . graphviz-dot))
     ;; Change .pdf association directly within the alist
     (setcdr (assoc "\\.pdf\\'" org-file-apps) "acroread %s")))

;;ces ;; Capture
;;ces (setq org-capture-templates
;;ces       '(
;;ces         ("j" "Journal" entry (file+datetree "~/org/journal.org")
;;ces          "\n* %?\n  Entered on %U")
;;ces         ("n" "Note" entry (file "~/org/notes.org")
;;ces          "\n* %?\n  Context:\n    %i\n  Entered on %U")
;;ces         ("u" "UVM/System Verilog Notes" entry (file "~/org/uvm.org")
;;ces          "\n* %?\n  Context:\n    %i\n  Entered on %U")
;;ces         ))

;; Diagrammmms
;; Source: http://pages.sachachua.com/.emacs.d/Sacha.html
(setq org-ditaa-jar-path (concat user-emacs-directory "/ditaa/ditaa0_9.jar"))
(setq org-plantuml-jar-path (concat user-emacs-directory "/plantuml/plantuml.7999.jar"))

(defun my-org-confirm-babel-evaluate (lang body)
  (and (not (string= lang "ditaa"))    ;; don't ask for ditaa
       (not (string= lang "plantuml")) ;; don't ask for plantuml
       (not (string= lang "latex"))    ;; don't ask for latex
       (not (string= lang "dot"))      ;; don't ask for graphviz
       ))
(setq org-confirm-babel-evaluate 'my-org-confirm-babel-evaluate)
(setq org-confirm-elisp-link-function 'yes-or-no-p)

(defun modi/org-export-to-html-txt-pdf ()
  "Export the org file to multiple formats."
  (interactive)
  (org-html-export-to-html)
  (org-ascii-export-to-ascii)
  (org-latex-export-to-pdf))

;; org-agenda related functions
;; http://sachachua.com/blog/2013/01/emacs-org-task-related-keyboard-shortcuts-agenda/
(defun sacha/org-agenda-done (&optional arg)
  "Mark current TODO as done.
This changes the line at point, all other lines in the agenda referring to
the same tree node, and the headline of the tree node in the Org-mode file."
  (interactive "P")
  (org-agenda-todo "DONE"))

(defun sacha/org-agenda-mark-done-and-add-followup ()
  "Mark the current TODO as done and add another task after it.
Creates it at the same level as the previous task, so it's better to use
this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-todo "DONE")
  (org-agenda-switch-to)
  (org-capture 0 "t")
  (org-metadown 1)
  (org-metaright 1))

(defun sacha/org-agenda-new ()
  "Create a new note or task at the current agenda item.
Creates it at the same level as the previous task, so it's better to use
this with to-do items than with projects or headings."
  (interactive)
  (org-agenda-switch-to)
  (org-capture 0))

(add-hook 'org-agenda-mode-hook
          (lambda ()
            ;; Override the key definition for org-exit
            (define-key org-agenda-mode-map "x" 'sacha/org-agenda-done)
            (define-key org-agenda-mode-map "X" 'sacha/org-agenda-mark-done-and-add-followup)
            ;; New key assignment
            (define-key org-agenda-mode-map "N" 'sacha/org-agenda-new)))


;;-------------------
;;ces additions

;; Use all files in org-directory with .org extension as agenda files
;(setq org-agenda-files (directory-files (expand-file-name org-directory) t "^[^\.][^#][[:alnum:]]+\.org$"))
(setq all-org-files (directory-files (expand-file-name org-directory) t "^[^\.][^#][[:alnum:]]+\.org$"))
(setq org-agenda-files all-org-files)
;; Prevent unintended edits in hidden areas
(setq org-catch-invisible-edits t)
;; Make statistic cookies hierarchical (like coverage!)
(setq org-hierarchical-todo-statistics t)
;; Don't propagate PROJECT tag to children
(setq org-tags-exclude-from-inheritance '("PROJECT"))
;; Make C-a and C-e consider leading stars, todo keywords, and trailing tags
(setq org-special-ctrl-a/e t)

;; Custom todo keywords
;; Source: http://doc.norang.ca/org-mode.html#OrgFiles
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h!)" "|" "CANCELED(c@/!)" "DELEGATED(l!)"))))

;; Custom todo keyword syntax highlighting
;; light faces
;; dark faces
(when 'dark-theme
 (setq org-todo-keyword-faces
       (quote (("TODO" :foreground "salmon" :weight bold)
               ("NEXT" :foreground "deepskyblue" :weight bold)
               ("DONE" :foreground "pale green" :weight bold)
               ("WAITING" :foreground "lightgoldenrod" :weight bold)
               ("HOLD" :foreground "burlywood" :weight bold)
               ("CANCELED" :foreground "pale green" :weight bold)
               ("DELEGATED" :foreground "pale green" :weight bold)))))

(when 'light-theme
 (setq org-todo-keyword-faces
       (quote (("TODO" :foreground "red" :weight bold)
               ("NEXT" :foreground "blue" :weight bold)
               ("DONE" :foreground "forest green" :weight bold)
               ("WAITING" :foreground "orange" :weight bold)
               ("HOLD" :foreground "burlywood" :weight bold)
               ("CANCELED" :foreground "forest green" :weight bold)
               ("DELEGATED" :foreground "forest green" :weight bold)))))

;; Enable quick todo keyword selection
(setq org-use-fast-todo-selection t)

;; Capture templates for: TODO tasks
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/org/refile.org")
               "* TODO %?\n")
              ("n" "note" entry (file "~/org/refile.org")
               "* %? :NOTE:\n"))))

;;-------------------
;; Custom agenda view

;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
;; Do not read startup settings for each agenda file
(setq org-agenda-inhibit-startup t)
;; Compact the block agenda view
(setq org-agenda-compact-blocks t)
;; Don't clutter agenda view with tags
(setq org-agenda-remove-tags t)
(setq org-agenda-span 1)

;; Custom agenda command definitions
(setq org-agenda-custom-commands
      (quote (("N" "Notes" tags "NOTE"
               ((org-agenda-overriding-header "Notes")
                (org-tags-match-list-sublevels t)))
              (" " "Agenda"
               ((agenda "" nil)
                (tags "REFILE"
                      ((org-agenda-overriding-header "Tasks to re-file")
                       (org-tags-match-list-sublevels nil) 
                       (org-agenda-files (quote ("~/org/refile.org"))) ))
                ;(tags-todo "Talise"
                ;      ((org-agenda-overriding-header "Talise")
                ;       (org-tags-match-list-sublevels 'indented)
                ;       (org-agenda-sorting-strategy '(category-keep))
                ;       (org-agenda-skip-function 
                ;        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                ;       (org-agenda-files (quote ("~/org/talise.org"))) ))
                ;(todo ""
                ;      ((org-agenda-overriding-header "A2B/Balius")
                ;       (org-tags-match-list-sublevels 'indented)
                ;       (org-agenda-sorting-strategy '(category-keep))
                ;       (org-agenda-skip-function 
                ;        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                ;       (org-agenda-files (quote ("~/org/a2b.org"))) ))
                ;(todo ""
                ;      ((org-agenda-overriding-header "Telsa")
                ;       (org-tags-match-list-sublevels 'indented)
                ;       (org-agenda-sorting-strategy '(category-keep))
                ;       (org-agenda-skip-function 
                ;        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                ;       (org-agenda-files (quote ("~/org/tesla.org"))) ))
                (tags-todo "ILV"
                      ((org-agenda-overriding-header "ILV")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files (quote ("~/org/ilv.org"))) ))
                (tags-todo "TBG"
                      ((org-agenda-overriding-header "TBG")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files (quote ("~/org/tbg.org"))) ))
                (tags-todo "ADVIP"
                      ((org-agenda-overriding-header "ADVIP")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files (quote ("~/org/advip.org"))) ))
                (tags-todo "DVMT"
                      ((org-agenda-overriding-header "DVMT")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files (quote ("~/org/dvmt.org"))) ))
                (todo ""
                      ((org-agenda-overriding-header "Other")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(priority-down category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files '("~/org/papers.org" "~/org/emacs.org" "~/org/meetings.org" "~/org/talise.org" "~/org/a2b.org" "~/org/tesla.org")) ))
                ))
              ("x" "Agenda"
               (;(agenda "" nil)
                (tags-todo "-Delegated-PERSONAL"
                      ((org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled)))) 
                       (org-agenda-files all-org-files) ))
                )
               nil)
              ("d" "Delegated Tasks"
               ((tags-todo "+Sreeveni"
                      ((org-agenda-overriding-header "Sreeveni")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files '("~/org/delegated.org")) ))
                (tags-todo "+Edward"
                      ((org-agenda-overriding-header "Edward")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files '("~/org/delegated.org")) ))
                (tags-todo "-Sreeveni-Edward/!"
                      ((org-agenda-overriding-header "Other")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(priority-down category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files '("~/org/delegated.org")) ))
                )
               nil)
              ("p" "Personal Tasks"
               ((todo ""
                      ((org-agenda-overriding-header "Personal Tasks")
                       (org-tags-match-list-sublevels 'indented)
                       (org-agenda-sorting-strategy '(category-keep))
                       (org-agenda-skip-function 
                        (quote (org-agenda-skip-entry-if (quote todo) (quote done) (quote scheduled))))
                       (org-agenda-files '("~/org/personal.org")) ))
                )
               nil))))

;;-------------------
;; Highlight high priority items
(setq org-priority-faces '((?A . (:foreground "magenta" :weight bold))))

;;-------------------
;; Set some tags to be auto-excluded from agenda log view
;;(defun my-org-auto-exclude-function (tag)
;;  (cond ((string= tag "PERSONAL") (concat "-" tag))))
;;(setq org-agenda-auto-exclude-function 'my-org-auto-exclude-function)


;;ces ;;-------------------
;;ces ;; Project definitions
;;ces (defun bh/is-project-p ()
;;ces   "Any task with a todo keyword subtask"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((has-subtask)
;;ces           (subtree-end (save-excursion (org-end-of-subtree t)))
;;ces           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;ces       (save-excursion
;;ces         (forward-line 1)
;;ces         (while (and (not has-subtask)
;;ces                     (< (point) subtree-end)
;;ces                     (re-search-forward "^\*+ " subtree-end t))
;;ces           (when (member (org-get-todo-state) org-todo-keywords-1)
;;ces             (setq has-subtask t))))
;;ces       (and is-a-task has-subtask))))
;;ces 
;;ces (defun bh/is-project-subtree-p ()
;;ces   "Any task with a todo keyword that is in a project subtree.
;;ces Callers of this function already widen the buffer view."
;;ces   (let ((task (save-excursion (org-back-to-heading 'invisible-ok)
;;ces                               (point))))
;;ces     (save-excursion
;;ces       (bh/find-project-task)
;;ces       (if (equal (point) task)
;;ces           nil
;;ces         t))))
;;ces 
;;ces (defun bh/is-task-p ()
;;ces   "Any task with a todo keyword and no subtask"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((has-subtask)
;;ces           (subtree-end (save-excursion (org-end-of-subtree t)))
;;ces           (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;ces       (save-excursion
;;ces         (forward-line 1)
;;ces         (while (and (not has-subtask)
;;ces                     (< (point) subtree-end)
;;ces                     (re-search-forward "^\*+ " subtree-end t))
;;ces           (when (member (org-get-todo-state) org-todo-keywords-1)
;;ces             (setq has-subtask t))))
;;ces       (and is-a-task (not has-subtask)))))
;;ces 
;;ces (defun bh/is-subproject-p ()
;;ces   "Any task which is a subtask of another project"
;;ces   (let ((is-subproject)
;;ces         (is-a-task (member (nth 2 (org-heading-components)) org-todo-keywords-1)))
;;ces     (save-excursion
;;ces       (while (and (not is-subproject) (org-up-heading-safe))
;;ces         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;ces           (setq is-subproject t))))
;;ces     (and is-a-task is-subproject)))
;;ces 
;;ces (defun bh/list-sublevels-for-projects-indented ()
;;ces   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;ces   This is normally used by skipping functions where this variable is already local to the agenda."
;;ces   (if (marker-buffer org-agenda-restrict-begin)
;;ces       (setq org-tags-match-list-sublevels 'indented)
;;ces     (setq org-tags-match-list-sublevels nil))
;;ces   nil)
;;ces 
;;ces (defun bh/list-sublevels-for-projects ()
;;ces   "Set org-tags-match-list-sublevels so when restricted to a subtree we list all subtasks.
;;ces   This is normally used by skipping functions where this variable is already local to the agenda."
;;ces   (if (marker-buffer org-agenda-restrict-begin)
;;ces       (setq org-tags-match-list-sublevels t)
;;ces     (setq org-tags-match-list-sublevels nil))
;;ces   nil)
;;ces 
;;ces (defvar bh/hide-scheduled-and-waiting-next-tasks t)
;;ces 
;;ces (defun bh/toggle-next-task-display ()
;;ces   (interactive)
;;ces   (setq bh/hide-scheduled-and-waiting-next-tasks (not bh/hide-scheduled-and-waiting-next-tasks))
;;ces   (when  (equal major-mode 'org-agenda-mode)
;;ces     (org-agenda-redo))
;;ces   (message "%s WAITING and SCHEDULED NEXT Tasks" (if bh/hide-scheduled-and-waiting-next-tasks "Hide" "Show")))
;;ces 
;;ces (defun bh/skip-stuck-projects ()
;;ces   "Skip trees that are not stuck projects"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;ces       (if (bh/is-project-p)
;;ces           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;ces                  (has-next ))
;;ces             (save-excursion
;;ces               (forward-line 1)
;;ces               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;ces                 (unless (member "WAITING" (org-get-tags-at))
;;ces                   (setq has-next t))))
;;ces             (if has-next
;;ces                 nil
;;ces               next-headline)) ; a stuck project, has subtasks but no next task
;;ces         nil))))
;;ces 
;;ces (defun bh/skip-non-stuck-projects ()
;;ces   "Skip trees that are not stuck projects"
;;ces   ;; (bh/list-sublevels-for-projects-indented)
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;ces       (if (bh/is-project-p)
;;ces           (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;ces                  (has-next ))
;;ces             (save-excursion
;;ces               (forward-line 1)
;;ces               (while (and (not has-next) (< (point) subtree-end) (re-search-forward "^\\*+ NEXT " subtree-end t))
;;ces                 (unless (member "WAITING" (org-get-tags-at))
;;ces                   (setq has-next t))))
;;ces             (if has-next
;;ces                 next-headline
;;ces               nil)) ; a stuck project, has subtasks but no next task
;;ces         next-headline))))
;;ces 
;;ces (defun bh/skip-non-projects ()
;;ces   "Skip trees that are not projects"
;;ces   ;; (bh/list-sublevels-for-projects-indented)
;;ces   (if (save-excursion (bh/skip-non-stuck-projects))
;;ces       (save-restriction
;;ces         (widen)
;;ces         (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;ces           (cond
;;ces            ((bh/is-project-p)
;;ces             nil)
;;ces            ((and (bh/is-project-subtree-p) (not (bh/is-task-p)))
;;ces             nil)
;;ces            (t
;;ces             subtree-end))))
;;ces     (save-excursion (org-end-of-subtree t))))
;;ces 
;;ces (defun bh/skip-project-trees-and-habits ()
;;ces   "Skip trees that are projects"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;ces       (cond
;;ces        ((bh/is-project-p)
;;ces         subtree-end)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-projects-and-habits-and-single-tasks ()
;;ces   "Skip trees that are projects, tasks that are habits, single non-project tasks"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;ces       (cond
;;ces        ((and bh/hide-scheduled-and-waiting-next-tasks
;;ces              (member "WAITING" (org-get-tags-at)))
;;ces         next-headline)
;;ces        ((bh/is-project-p)
;;ces         next-headline)
;;ces        ((and (bh/is-task-p) (not (bh/is-project-subtree-p)))
;;ces         next-headline)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-project-tasks-maybe ()
;;ces   "Show tasks related to the current restriction.
;;ces When restricted to a project, skip project and sub project tasks, habits, NEXT tasks, and loose tasks.
;;ces When not restricted, skip project and sub-project tasks, habits, and project related tasks."
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;ces            (next-headline (save-excursion (or (outline-next-heading) (point-max))))
;;ces            (limit-to-project (marker-buffer org-agenda-restrict-begin)))
;;ces       (cond
;;ces        ((bh/is-project-p)
;;ces         next-headline)
;;ces        ((and (not limit-to-project)
;;ces              (bh/is-project-subtree-p))
;;ces         subtree-end)
;;ces        ((and limit-to-project
;;ces              (bh/is-project-subtree-p)
;;ces              (member (org-get-todo-state) (list "NEXT")))
;;ces         subtree-end)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-project-tasks ()
;;ces   "Show non-project tasks.
;;ces Skip project and sub-project tasks, habits, and project related tasks."
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let* ((subtree-end (save-excursion (org-end-of-subtree t))))
;;ces       (cond
;;ces        ((bh/is-project-p)
;;ces         subtree-end)
;;ces        ((bh/is-project-subtree-p)
;;ces         subtree-end)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-non-project-tasks ()
;;ces   "Show project tasks.
;;ces Skip project and sub-project tasks, habits, and loose non-project tasks."
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let* ((subtree-end (save-excursion (org-end-of-subtree t)))
;;ces            (next-headline (save-excursion (or (outline-next-heading) (point-max)))))
;;ces       (cond
;;ces        ((bh/is-project-p)
;;ces         next-headline)
;;ces        ((and (bh/is-project-subtree-p)
;;ces              (member (org-get-todo-state) (list "NEXT")))
;;ces         subtree-end)
;;ces        ((not (bh/is-project-subtree-p))
;;ces         subtree-end)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-projects-and-habits ()
;;ces   "Skip trees that are projects and tasks that are habits"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((subtree-end (save-excursion (org-end-of-subtree t))))
;;ces       (cond
;;ces        ((bh/is-project-p)
;;ces         subtree-end)
;;ces        (t
;;ces         nil)))))
;;ces 
;;ces (defun bh/skip-non-subprojects ()
;;ces   "Skip trees that are not projects"
;;ces   (let ((next-headline (save-excursion (outline-next-heading))))
;;ces     (if (bh/is-subproject-p)
;;ces         nil
;;ces       next-headline)))
;;ces 
;;ces (defun bh/find-project-task ()
;;ces   "Move point to the parent (project) task if any"
;;ces   (save-restriction
;;ces     (widen)
;;ces     (let ((parent-task (save-excursion (org-back-to-heading 'invisible-ok) (point))))
;;ces       (while (org-up-heading-safe)
;;ces         (when (member (nth 2 (org-heading-components)) org-todo-keywords-1)
;;ces           (setq parent-task (point))))
;;ces       (goto-char parent-task)
;;ces       parent-task)))

;;-------------------
;; Archiving
(setq org-archive-mark-done nil)
(setq org-archive-location "%s_archive::* Archived Tasks")

(defun bh/skip-non-archivable-tasks ()
  "Skip trees that are not available for archiving"
  (save-restriction
    (widen)
    ;; Consider only tasks with done todo headings as archivable candidates
    (let ((next-headline (save-excursion (or (outline-next-heading) (point-max))))
          (subtree-end (save-excursion (org-end-of-subtree t))))
      (if (member (org-get-todo-state) org-todo-keywords-1)
          (if (member (org-get-todo-state) org-done-keywords)
              (let* ((daynr (string-to-int (format-time-string "%d" (current-time))))
                     (a-month-ago (* 60 60 24 (+ daynr 1)))
                     (last-month (format-time-string "%Y-%m-" (time-subtract (current-time) (seconds-to-time a-month-ago))))
                     (this-month (format-time-string "%Y-%m-" (current-time)))
                     (subtree-is-current (save-excursion
                                           (forward-line 1)
                                           (and (< (point) subtree-end)
                                                (re-search-forward (concat last-month "\\|" this-month) subtree-end t)))))
                (if subtree-is-current
                    subtree-end ; Has a date in this month or last month, skip it
                  nil))  ; available to archive
            (or subtree-end (point-max)))
        next-headline))))

;;-------------------
;; Refiling

; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))
(setq org-refile-target-verify-function 'bh/verify-refile-target)


;(setq org-agenda-files all-org-files)


(setq setup-org-loaded t)
(provide 'setup-org)
