;;
;; Mike De La Loza
;; email: mikedll@mikedll.com
;; web: mikedll.com
;;
;;
;; These settings are to separate emacs from its stupid default
;; behavior that I happen to disagree with. Like
;; disabling "happy menu icons" and the like.
;;

(defun font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(if (font-existsp "Monaco") (set-face-attribute 'default nil :font "Monaco"))

;; Does more harm than good
(global-set-key "\C-z" nil)

;; Start emacs in home, not C:/emacs/bin
;; http://stackoverflow.com/questions/60464/changing-the-default-folder-in-emacs
(setq default-directory (concat home-dir "/"))

;; Stop emacs' spam
(setq inhibit-startup-screen t)

;; Kill menu, tool bar, and scroll bar
(menu-bar-mode)
(tool-bar-mode)
(set-window-scroll-bars (minibuffer-window) nil)


;; The default vc-git mode is an interference to egg/magit.
(setq vc-handled-backends (remq 'Git vc-handled-backends))


;; Only search file names in dired
(require 'dired)
(require 'dired-isearch)
(define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
(define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
(define-key dired-mode-map (kbd "ESC C-s") 'dired-isearch-forward-regexp)
(define-key dired-mode-map (kbd "ESC C-r") 'dired-isearch-backward-regexp)

;; Emacs crashes without this on os x
(defun fix-tramp()
  ;; Hack to avoid tramp recursive load.
  (ido-mode)
  (require 'tramp)
  (ido-mode)
  )

(if (is-osx) (fix-tramp))
