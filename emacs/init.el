(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(setq package-native-compile t)
(setq use-package-always-ensure t)
(setq use-package-always-defer t)

(setq custom-file "~/.config/emacs/custom.el")

(add-hook 'prog-mode-hook (lambda () (setq display-line-numbers 'relative)))

(global-hl-line-mode 1)

(use-package exec-path-from-shell :init (exec-path-from-shell-initialize))


(use-package undo-fu)

(use-package evil
  :demand t
  :ensure t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-fu)
  :config (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config (evil-collection-init))


(use-package vertico :init (vertico-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package marginalia :init (marginalia-mode))

(use-package consult
  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)
  (advice-add #'register-preview :override #'consult-register-window)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))
  (setq consult-narrow-key "<"))


(use-package corfu
  :init
  (global-corfu-mode))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-elisp-block))


(use-package emacs
  :init
  (setq completion-cycle-threshold 3)
  (setq tab-always-indent 'complete)
  (setq text-mode-ispell-word-completion nil)
  (setq read-extended-command-predicate #'command-completion-default-include-p))


(use-package magit :config (setq magit-diff-refine-hunk t))

(use-package diff-hl
  :after magit
  :config
  (diff-hl-flydiff-mode t)
  :hook
  (magit-pre-refresh . (lambda () (diff-hl-magit-pre-refresh)))
  (magit-post-refresh . (lambda () (diff-hl-magit-post-refresh)))
  (prog-mode . diff-hl-mode))


(use-package zig-mode)
(use-package rust-mode)
(use-package go-mode)
