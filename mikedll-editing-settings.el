;;
;; These are settings (tab sizes, etc) that I prefer for when I edit code.
;;

;; Helpful for text editing
(setq column-number-mode t)
(global-font-lock-mode t)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq hi-lock-mode t)
(setq transient-mark-mode t)
(setq make-backup-files nil)

;; Helpful for Programming
(setq compilation-scroll-output 1)
(custom-set-variables
 '(case-fold-search t)
 '(standard-indent 2))
(global-set-key "\C-xg" 'goto-line)
(global-set-key "\C-x'" 'recompile)
(linum-mode)


;; Org mode
(setq user-full-name "Michael Rivera")
(setq org-html-validation-link nil)
(setq org-export-html-postamble nil)


;; Lisp
(global-set-key (kbd "C-S-e") 'eval-region)

(defun save-dt()
  (interactive)
  (let ((possible-git (find-root-dir-by-pattern ".git$" (file-name-directory (if (null buffer-file-name) default-directory (buffer-file-name))))))
    (unless (null possible-git)
			(desktop-save possible-git t)
      (desktop-clear))))

(defun snapshot-dt()
  (interactive)
  (let ((possible-git (find-root-dir-by-pattern ".git$" (file-name-directory (if (null buffer-file-name) default-directory (buffer-file-name))))))
    (unless (null possible-git)
			(desktop-save possible-git t))))

(defun restore-dt()
  (interactive)
  ;; (desktop-clear)
  (let ((possible-git (find-root-dir-by-pattern ".git$" (file-name-directory (if (null buffer-file-name) default-directory (buffer-file-name))))))
    (unless (null possible-git)
			(desktop-read possible-git))))
      
(global-set-key (kbd "s-i u") 'save-dt)
(global-set-key (kbd "s-i w") 'snapshot-dt)
(global-set-key (kbd "s-i o") 'restore-dt)




(defun browse-to-url-in-region ()
  (interactive)
  (let ((s (buffer-substring (region-beginning) (region-end))))
    (cond ((string-match "^https?://" s) (browse-url s))
          (t (browse-url (concat "http://www.google.com/#q=" s))))))

(defun my/dired-browse-file ()
  (let* ((f-to-open (dired-get-filename t t)))
    (message f-to-open)))    
  ;; (unless (null )
  ;;   (message )
    
(defun browse-to-url-in-region ()
  (interactive)
  (let ((s (buffer-substring (region-beginning) (region-end))))
    (cond ((string-match "^https?://" s) (browse-url s))
          (t (browse-url (concat "http://www.google.com/#q=" s))))))

(global-set-key (kbd "C-x j") 'browse-to-url-in-region)
;; (global-set-key (kbd "C-x j") 'dired-open-file-in-browser)


(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))



