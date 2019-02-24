
;; My customization.
(require 'railsinterp)
(require 'nanter)

;; Browsing capability
;;(require 'w3m-load)


;; coincidently, on osx, we already loaded ido mode.
(ido-mode t)
(setq ido-enable-flex-matching t)

;; Display ido results vertically, rather than horizontally
(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))

(defun ido-disable-line-trucation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-trucation)

;; note that rinari already covers this in its own hook,
;; so we might not need it.
(defun ido-find-file-in-tag-files ()
  (interactive)
  (save-excursion
    (let ((enable-recursive-minibuffers t))
      (visit-tags-table-buffer))
    (find-file
     (expand-file-name
      (ido-completing-read
       "Project file: " (tags-table-files) nil t)))))
(global-set-key (kbd "C-c C-f") 'ido-find-file-in-tag-files)


;; From matlab.el installation
;; (autoload 'matlab-mode "matlab" "Enter MATLAB mode." t)
;; (autoload 'matlab-shell "matlab" "Interactive MATLAB mode." t)
;; conflicts with objective c
;; (setq auto-mode-alist (cons '("\\.m\\'" . matlab-mode) auto-mode-alist))


;; doesn't work
;; (require 'find-recursive)


;; Egg Git
;; Egg loads very slowly, so we wrap its loading
;; in a log key.
;; (defun load-egg()
;;   (interactive)
;;   (unless (fboundp 'magit-status)
;;     (require 'egg)
;;     (if (is-win)
;;         (cond
;;          ((file-exists-p "c:/Program Files/Git/bin/git.exe")
;;           (setq egg-git-command "c:/Program Files/Git/bin/git.exe"))
;;          ((file-exists-p "c:/Program Files (x86)/Git/bin/git.exe")
;;           (setq egg-git-command "c:/Program Files (x86)/Git/bin/git.exe")))))
;;   (magit-status)
;;   )
(setq magit-save-repository-buffers nil)
(global-set-key (kbd "C-x v d") 'magit-status)
;; (if (not (is-win))
;;      (define-key magit-file-mode-map (kbd "C-x g") nil)
;;   )


;; Optional mode for rhtml
;; (require 'rhtml-minor-mode)





;; windows utilities
(if (is-win) (require 'mikedll-windows-help))


;;;;;;;;;;;;;;;;;;;;;;;;;;;; SQL
;;;;;;;;;;;;;;;;;;;;;;;;;;;; for some reason, this works
;;;;;;;;;;;;;;;;;;;;;;;;;;;; better than the default sql version.
;;;;;;;;;;;;;;;;;;;;;;;;;;;; loading is a performance hit. move elsewhere.
;; (require 'sql) 
(setq sql-user "root")
(setq sql-password "")
(setq sql-server "localhost")

(add-hook 'sql-mode-hook
       '(lambda ()
          (local-set-key (kbd "C-S-e") 'sql-send-region)))


;; Nathaniel Flath's save visited files mode
;; Doesn't seem to do anything helpful...may comment back in later.
;; (require 'save-visited-files)
;; (setq save-visited-files-auto-restore t)
;; (save-visited-files-restore)

;; Rinari
;; slight performance hit to load this. consider dynamically
;; loading.
(add-to-list 'load-path (concat emacs-dir "/rinari"))
(require 'rinari)
(setq rinari-tags-file-name "TAGS")

;; Full Ack
(defun toggle-ack-prompt()
  (interactive)
  (if (custom-reevaluate-setting 'ack-prompt-for-directory)
    (custom-set-variables '(ack-prompt-for-directory nil))
    (custom-set-variables '(ack-prompt-for-directory t))
    )

  (if (custom-reevaluate-setting 'ack-prompt-for-directory)
      (message "ack directory prompt is on")
      (message "ack directory prompt is off")
      )
  )

(require 'full-ack)
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

(cond ((is-win)
       ;; this stuff is broken on your home laptop
       (setq ack-executable "perl.exe")
       (custom-set-variables '(ack-arguments (list (concat "c:\\Users\\" (getenv "USERNAME") "\\Documents\\My Dropbox\\scripts\\ack"))))
       )
      )
(global-set-key (kbd "C-S-s") 'ack)
(global-set-key (kbd "C-S-M-s") 'toggle-ack-prompt)
(setq ack-context 0) ;; I also had to change full-ack to omit this entirely when calling ack


;; highlighting function mode
(setq which-func-modes t)
(which-func-mode 1)


;; Move for R
;; (add-to-list 'load-path (concat emacs-dir "/ess"))
;; (require 'ess-site)
;; (add-to-list 'auto-mode-alist '("\\.r\\'" . R-mode))


(require 'analog)
(custom-set-variables '(analog-timer-period t))
(custom-set-variables '(analog-use-timer t))
(custom-set-variables '(analog-entry-list ()))


;; tramp
;; This is a performance hit. consider moving elsewhere.
;; on windows, see c:/emacs-23.2/lisp/net/tramp.el
(require 'tramp)

;; this is sort of hacked on to get tramp working on windows with ec2. can be extended so reset these variables in a more dynamic way...
(custom-set-variables
 '(tramp-methods (quote
		  (("plink"
		    (tramp-login-program        "plink")
		    (tramp-login-args           (("-i \"c:\\Users\\michaelr\\Documents\\My Dropbox\\Auth and Auth\\AmazonAsiaKeyPair.ppk\"") ("-l" "%u") ("-P" "%p")
						 ("-ssh") ("%h")))
		    (tramp-remote-sh            "/bin/sh")
		    (tramp-copy-program         nil)
		    (tramp-copy-args            nil)
		    (tramp-copy-keep-date       nil)
		    (tramp-password-end-of-line "xy") ;see docstring for "xy"
		    (tramp-default-port         22)
		    ))
		  )
  )
 )

(setq tramp-default-method "plink")

(if (locate-library "edit-server")
   (progn
     (require 'edit-server)
     (setq edit-server-new-frame nil)
     (edit-server-start)))



;; (require 'degruvy-mode)
;; (setq degruvy-root-dir "/Users/michaelrivera/work/degruvy")
;; (add-hook 'after-change-major-mode-hook 'degruvy-check-minor-mode)


(require 'integration-with-mikedll.com)


(require 'tidy)
(setq tidy-config-file (concat common-dir "/tidy.config"))

(require 'csv-mode)

(provide 'load-tools)


