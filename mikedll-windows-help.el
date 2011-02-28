;;
;; Mike De La Loza
;; email: mikedll@mikedll.com
;; web: mikedll.com
;;
;; Handy functions for playing with emacs on windows.
;;


(defun win-launch-explorer()
  (interactive)
  (shell-command "start .")
  )

(defun win-launch-work-cmd()
  (interactive)
  ;; need to actually open a new window with this in it.
  (shell-command "cmd.exe /k e:; cd e:/projects/bcg/imd")
  )

(defun capture-windows-key()
"Need to assign the Windows key to super, so that we can bing to it.
Credit: http://xahlee.org/emacs/keyboard_shortcuts.html
  "
  (setq w32-pass-lwindow-to-system t
	w32-pass-rwindow-to-system t 
	w32-pass-apps-to-system t
	w32-lwindow-modifier 'super ;; Left Windows key 
	w32-rwindow-modifier 'super ;; Right Windows key 
	w32-apps-modifier 'hyper) ;; Menu key
  )


(defun caspol-cmd (args)
  (let* ((buf (get-buffer-create "*caspol*"))
	 (full-caspol-dir "c:/Windows/Microsoft.NET/Framework/v2.0.50727")
	 (default-directory (concat full-caspol-dir "/"))
	 (caspol-exec (concat full-caspol-dir "/CasPol")))

    (with-current-buffer buf
      (erase-buffer))
    (apply 'start-process "caspol" buf caspol-exec args)
    (display-buffer "*caspol*")))


(defun rsp-dll-path (dll-path)
  (let ((args (list "-m" "-rsp" dll-path)))
    (caspol-cmd args)))

(defun rsg-dll-path (dll-path)
  (let ((args (list "-rsg" dll-path)))
    (caspol-cmd args)))

(defun caspol-lg ()
  (caspol-cmd (list "-lg")))

(defun caspol-cg-all-to (perm)
  (caspol-cmd (list "-q" "-m" "-cg" "All_Code" perm)))

(defun caspol-examples-hide-from-execution ()
  (caspol-lg)
  (rsg-dll-path "E:\\projects\\mine\\sample.dll")
  (rsp-dll-path "E:\\projects\\mine\\sample.dll")
  (rsg-dll-path "E:\\projects\\mine\\sample.dll")
  (caspol-cg-all-to "Nothing")
  )

(defun winservices-cmd (args)
  (let* ((buf (get-buffer-create "*winservices*"))
	 (sc-dir "c:/Windows/System32")
	 (default-directory (concat sc-dir "/"))
	 (sc-exec (concat sc-dir "/sc.exe")))

    (with-current-buffer buf
      (erase-buffer))
    (apply 'start-process "sc" buf sc-exec args)
    (display-buffer "*winservices*")))

(defun winservices-build-list()
  (with-temp-buffer
    (let ((service-list (list)))
      (call-process "sc" nil t nil "query" "state=" "all")
      (goto-char (point-min))
      (while (re-search-forward "SERVICE_NAME: \\([A-Za-z0-9]+$\\)" nil t)
	(message (match-string 1))
      	(push (match-string 1) service-list))
      service-list)))

(defun read-from-region-or-prompt (prompt default-list)
  (cond ((use-region-p) (buffer-substring (region-beginning) (region-end)))
	(t (ido-completing-read prompt default-list))))

(defun winservices-read ()
  (read-from-region-or-prompt "service name: " (winservices-build-list)))

(defun winservices-query ()
  (interactive)
  (winservices-cmd (list"query" (winservices-read))))

(defun winservices-stop ()
  (interactive)
  (winservices-cmd (list "stop" (winservices-read))))

(defun winservices-start ()
  (interactive)
  (winservices-cmd (list "start" (winservices-read))))

(defun configure-windows-help ()
  (capture-windows-key)
  (global-set-key (kbd "s-w") 'win-launch-explorer)
  (global-set-key (kbd "s-c s q") 'winservices-query)
  (global-set-key (kbd "s-c s o") 'winservices-stop)
  (global-set-key (kbd "s-c s s") 'winservices-start))

(configure-windows-help)

(provide 'mikedll-windows-help)
