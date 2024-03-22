;; Package managment
(package-initialize)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-native-compile t)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)


;; Settings
(define-key isearch-mode-map [escape] 'isearch-abort)
(define-key isearch-mode-map "\e" 'isearch-abort)
(global-set-key [escape] 'keyboard-escape-quit)

(set-face-attribute 'default nil :font "Fira Code")

(setq custom-file "~/.emacs.d/custom.el")
(setq tab-always-indent 'complete)
(setq completion-auto-select 'second-tab)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(electric-pair-mode)

(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))

(add-hook 'prog-mode-hook #'eglot-ensure)
(add-hook 'prog-mode-hook #'flymake-mode)

(setq help-at-pt-display-when-idle t)

;; thx ebn :)
(add-to-list 'display-buffer-alist
         '("\\*eshell\\*"
           (display-buffer-in-side-window)
           (side . bottom)
           (slot . 0)
           (window-parameters
             (no-delete-other-windows . t))))

(defun toggle-eshell ()
  "Toggle eshell."
  (interactive)
  (if-let ((w (get-buffer-window "*eshell*")))
      (delete-window w)
    (eshell)))
(global-set-key (kbd "C-c t e") #'toggle-eshell)


;; Packages
(use-package ef-themes :ensure t
  :init
  (load-theme 'ef-bio t))

(use-package vertico :demand :config (vertico-mode))

(use-package consult
  :config 
  (setq read-buffer-completion-ignore-case t
	read-file-name-completion-ignore-case t
	completion-ignore-case t))

(use-package corfu
  :demand
  :custom
  (corfu-auto t)
  :config
  (global-corfu-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :init
  (evil-collection-init))

(use-package magit :config (setq magit-diff-refine-hunk t))

(use-package diff-hl
  :config
  (diff-hl-flydiff-mode t)
  :hook
  (prog-mode . diff-hl-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package zig-mode)
(use-package rust-mode)
(use-package go-mode)
