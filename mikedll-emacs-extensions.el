;;
;; Mike De La Loza
;; email: mikedll@mikedll.com
;; web: mikedll.com
;;

(defun curli (url)
  "Inserts the results of a curl call into the buffer.
  This could be replaced with url.el stuff"
  (let ((cookie (concat emacs-dir "/data/mainCookieJar.dat")))
    (call-process "curl.exe" nil t nil "-b" cookie "-c" cookie "-s" url)))

(defun find-root-dir-by-pattern (pattern dir &optional last-dir)
  "Returns dir if it contains a file matching pattern. Else, returns to the
nearest ancestor directory that contains a file matching pattern. Else, returns nil.

If last-dir is nil, this assumes this is the first call,
and it calls expad-file-name on dir."
  
  (let ((dir (if (null last-dir) (expand-file-name dir) dir)))
    (cond ((equal dir last-dir) nil)
	  ((directory-files dir nil pattern t) dir)
	  (t (find-root-dir-by-pattern pattern (file-name-directory (directory-file-name dir)) dir)))))

(defun repl-eval (repl-proc-in repl-launch-func)
  (let ((s (if (use-region-p)
	       (buffer-substring (region-beginning) (region-end))
	     (buffer-substring (line-beginning-position) (line-end-position)))))
    (repl-eval-string s repl-proc-in repl-launch-func)))

(defun repl-eval-buffer (repl-proc-in repl-launch-func)
  (repl-eval-string (buffer-string) repl-proc-in repl-launch-func))


(defun repl-eval-string (s repl-proc-in repl-launch-func)
  (interactive) ;;  "r" doesn't work if mark hasn't been set.
  
  (let* ((repl-proc (if (or (null repl-proc-in)
			    (not (eq 'run (process-status repl-proc-in))))
			(funcall repl-launch-func)))
	 (result-buffer (process-buffer repl-proc))
	 (s-terminated (if (string-equal "\n" (substring s (1- (length s))))
			   s
			 (concat s "\n"))))
    
    (with-current-buffer (get-buffer-create result-buffer)
      (erase-buffer)
      (process-send-string repl-proc s-terminated)
      (display-buffer result-buffer))))

(defun launch-repl (repl-proc-name repl-result-buffer repl-proc-filter working-dir repl-executable repl-args)
  "Returns a process that is listening for incoming strings. The process' output will be bound to repl-result-buffer."
  
  (let ((buf (get-buffer-create repl-result-buffer)))
    (with-current-buffer buf
      (if working-dir
	  (setq default-directory working-dir))

      (let ((repl-proc (apply 'start-process repl-proc-name buf repl-executable repl-args)))
	(set-process-filter repl-proc repl-proc-filter)
	repl-proc))))


(defun refresh-ruby-tags()
  (interactive)
  (let* ((root-git-dir (find-root-dir-by-pattern ".git$" default-directory))
	 (command (if root-git-dir
		      (concat "ctags -e --Ruby-kinds=-f -o TAGS -R " root-git-dir))))
    (unless (null root-git-dir)
       (shell-command command))))

(global-set-key (kbd "C-x t") 'refresh-ruby-tags)


