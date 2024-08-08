(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
;; keep the installed packages in .emacs.d
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
;; update the package metadata is the local cache is missing
(unless package-archive-contents
  (package-refresh-contents))

(setq-default truncate-lines t
              indent-tabs-mode nil)

(setq inhibit-startup-message t
      ring-bell-function 'ignore
      line-number-mode t
      column-number-mode t
      require-final-newline t
      uniquify-buffer-name-style 'forward
      interprogram-paste-before-kill t
      backup-inhibited t
      auto-save-default nil)

(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(if window-system
    (progn
      (scroll-bar-mode -1)
      (tool-bar-mode -1)
      (tooltip-mode -1)))

(global-auto-revert-mode t)

(show-paren-mode)
(electric-pair-mode)

(ido-mode t)
(setq ido-enable-flex-matching t)

(put 'dired-find-alternate-file 'disabled nil)

(setq org-hide-emphasis-markers t)

(setq lpr-command "lp"
      lpr-printer-switch "-d "
      lpr-add-switches nil
      ps-paper-type 'a4
      pr-gv-command "zathura")

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (concat user-emacs-directory "places"))

;; Use shift <arrow> to navigate between open windows
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

(defalias 'list-buffers 'ibuffer)
(defalias 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(add-to-list 'default-frame-alist
             '(font . "JetBrainsMono Nerd Font Mono 12"))

;; M-SPC is used to change the OS input source
(global-unset-key (kbd "M-SPC"))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-verbose t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package whitespace
  :init
  (dolist (hook '(prog-mode-hook text-mode-hook))
    (add-hook hook #'whitespace-mode))
  (add-hook 'before-save-hook #'whitespace-cleanup)
  :config
  (setq whitespace-line-column 120) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package yaml-mode
  :ensure t)

(use-package ledger-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (rust-mode . lsp)
  :commands lsp)

(use-package flyspell
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package zenburn-theme
  :ensure t)

(setq zenburn-scale-org-headlines t)
(load-theme 'zenburn t)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
