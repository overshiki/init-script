(require 'package)

(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(setq package-list
			'(corfu
				cape
				use-package
				auto-highlight-symbol
				auto-complete
				highlight-parentheses
				clipmon
				highlight-indent-guides
				go-mode
				haskell-mode
				futhark-mode
				racket-mode
				tuareg
				julia-mode
				rust-mode
				markdown-mode
				elixir-mode
				scala-mode
				))

(package-initialize)
(dolist (package package-list)
  (unless (package-installed-p package)
	  (package-refresh-contents)
	  (package-install package)))

;;; -*- lexical-binding: t -*-
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(auto-highlight-symbol cape corfu)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(tab-bar-mode t)
(setq-default tab-width 2)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; (global-hl-line-mode 1)
;; (set-face-attribute 'hl-line nil :foreground nil)
(global-display-line-numbers-mode 1)

(setq-default cursor-type 'bar)


(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(global-auto-highlight-symbol-mode t)

(define-key global-map (kbd "C-;") 'comment-line)

(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(define-key global-map (kbd "C-o") 'end-of-line-and-indented-new-line)
(define-key global-map (kbd "C-.") 'find-file)
(define-key global-map (kbd "C-z") 'undo)
(define-key global-map (kbd "C-x C-e") 'end-of-buffer)
(define-key global-map (kbd "C-x C-g") 'beginning-of-buffer)

(setq make-backup-files nil) ; stop creating ~ files

(corfu-mode t)
