;; Since the default package archive doesn't include everything necessary, the marmalade, and melpa repositories are also added.
(package-initialize)

;; Install use-package for managing packages
(add-to-list 'load-path "~/.emacs.d/use-package")
(require 'use-package)

;; Configure proxy servers to be used
(load-file "~/.emacs.d/proxy_conf.el")

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tango-dark)))
 '(package-selected-packages
   (quote
    (xah-fly-keys helm dired-subtree projectile web-mode auto-complete powerline which-key tabbar))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; I want to skip straight to the scratch buffer. This turns off the splash screen and puts me straight into the scratch buffer. I don't really care to have anything in there either, so turn off the message while we're at it. Since I end up using org-mode most of the time, set the default mode accordingly.
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; Emacs starts up with way too much enabled. Turn off the scroll bar, menu bar, and tool bar. There isn't really a reason to have them on.
(scroll-bar-mode -1)
(tool-bar-mode -1)
;;(menu-bar-mode -1)

;; There are some behaviors in Emacs that aren't intuitive. Since I pair with others that don't know how Emacs handles highlighting, treat regions like other text editors. This means typing when the mark is active will write over the marked region. Also, make the common highlighting keystrokes work the way most people expect them to. This saves a lot of time explaining how to highlight areas of text. Emacs also has it's own clipboard and doesn't respond to the system clipboard by default, so tell Emacs that we're all friends and can get along.
(delete-selection-mode t)
(transient-mark-mode t)
(setq x-select-enable-clipboard t)

;; I have some modifications to the default display. First, a minor tweak to the frame title. It's also nice to be able to see when a file actually ends. This will put empty line markers into the left hand side.
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; Nobody likes to have to type out the full yes or no when Emacs asks. Which it does often. Make it one character.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Always highlight parentheses.
(show-paren-mode t)

;; Ido mode provides a nice way to navigate the filesystem. This is mostly just turning it on.
(ido-mode t)

;; Turn on line numbers
(global-linum-mode 1)

;; Start emacs in fullscreen
(toggle-frame-maximized)

;; Display folder structure
(use-package dired
  ;; :config (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  :config
  (setq-default dired-listing-switches "-lhva"))

;; Tab menu on top of the screen
;; https://www.emacswiki.org/emacs/TabBarMode#toc3
(use-package tabbar
  :config (progn
	    (tabbar-mode)
	    (setq tabbar-buffer-groups-function
		  (lambda ()
		    (list "All")))
	    )
  :ensure t)

;; --------------------------------------
;;  Eronomy mode with Xah Fly Keys
;; --------------------------------------
;; https://github.com/BLeeEZ/xah-fly-keys
;; http://ergoemacs.org/misc/ergoemacs_vi_mode.html
;; http://ergoemacs.org/misc/xah-fly-keys_customization.html
(use-package xah-fly-keys
  :load-path "~/.emacs.d/xah-fly-keys/"
  :init (setq xah-fly-use-control-key nil)
  :config
  (xah-fly-keys-set-layout "qwertz")
  (xah-fly-keys 1)
  ;; custom bindungs
  (define-key xah-fly--tab-key-map (kbd "j") 'tabbar-backward-tab) ;;[lead TAB j]
  (define-key xah-fly--tab-key-map (kbd "l") 'tabbar-forward-tab)  ;;[lead TAB l]
)

;; Activates a window to show available shortcuts
;;https://github.com/justbur/emacs-which-key
(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-right)
  :ensure t)

;; Powerline on the bottom of the screen
;;https://github.com/milkypostman/powerline
(use-package powerline
  :config
  (powerline-default-theme)
  :ensure t)

;; --------------------------------------
;;  Config auto complete.
;; --------------------------------------
(use-package auto-complete
  :config
  (use-package auto-complete-config)
  ;; (after (:ac-html-bootstrap) (add-to-list 'ac-modes 'slime-repl-mode))
  ;; (after (:js2-mode) (add-to-list 'ac-modes 'js2-mode))
  ;; (after (:js-mode) (add-to-list 'ac-modes 'js-mode))
  ;; (after (:ruby-mode) (add-to-list 'ac-modes 'ruby-mode))
  (ac-config-default)
  :ensure t)

;; --------------------------------------
;;  Web mode for displaying html and php files nice and autocomplete
;; --------------------------------------
(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  :ensure t)

;; Projectile
;; https://github.com/bbatsov/projectile
(use-package projectile
  :config
  (projectile-mode)
  :ensure t)

;; Dired-Subtree
;; https://github.com/Fuco1/dired-hacks
(use-package dired-subtree
  :config
  (define-key dired-mode-map "i" 'dired-subtree-insert)
  (define-key dired-mode-map ";" 'dired-subtree-remove)
  :ensure t)

;; helm
;; https://github.com/emacs-helm/helm/wiki#install
(use-package helm
  :config
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
  (define-key helm-map (kbd "C-i") 'helm-previous-line)
  (define-key helm-map (kbd "C-j") 'helm-beginning-of-buffer)
  (define-key helm-map (kbd "C-k") 'helm-next-line)
  (define-key helm-map (kbd "C-l") 'helm-end-of-buffer)
  (define-key xah-fly-leader-key-map (kbd "f") 'helm-buffers-list)
  (define-key xah-fly-c-keymap (kbd "i") 'helm-bookmarks)
  (define-key xah-fly-c-keymap (kbd "e") 'helm-find-files)
  (define-key xah-fly-t-keymap (kbd "l") 'helm-show-kill-ring)
  (define-key xah-fly-key-map (kbd "a") 'helm-M-x)
  :ensure t)

;; Global key bindings for ergonomic movement
(global-set-key (kbd "C-i") 'previous-line)
(global-set-key (kbd "C-j") 'backward-char)
(global-set-key (kbd "C-k") 'next-line)
(global-set-key (kbd "C-l") 'forward-char)
(global-set-key (kbd "C-u") 'backward-word)
(global-set-key (kbd "C-o") 'forward-word)
