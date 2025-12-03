(require 'package)

(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("nongnu" . "https://mirrors.ustc.edu.cn/elpa/nongnu/")))

(setq package-list
      '(corfu
        cape
        jedi
        company
        multiple-cursors
        use-package
        auto-highlight-symbol
        auto-complete
        highlight-parentheses
        clipmon
        highlight-indent-guides
        swiper-helm
        lsp-haskell
        doom-themes
        go-mode
        haskell-mode
        futhark-mode
        racket-mode
        tuareg         ;;; ocaml
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
 '(package-selected-packages
   '(auto-complete auto-highlight-symbol clipmon elixir-mode
                   futhark-mode go-mode haskell-mode
                   highlight-indent-guides highlight-parentheses jedi
                   julia-mode markdown-mode multiple-cursors
                   racket-mode rust-mode scala-mode toggle-term tuareg)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu Mono" :foundry "DAMA" :slant normal :weight normal :height 170 :width normal))))
 )

;; (add-hook 'python-mode-hook 'jedi:setup)

;; use company instead of this
;; ;; https://stackoverflow.com/questions/8095715/emacs-auto-complete-mode-at-startup
;; (global-auto-complete-mode t)
;; (defun auto-complete-mode-maybe ()
;;   "No maybe for you. Only AC!"
;;   (unless (minibufferp (current-buffer))
;;     (auto-complete-mode 1)))

;; I prefer no theme in the end
;; (load-theme 'doom-dark+ :no-confirm)
(load-theme 'doom-ayu-dark :no-confirm)

(tab-bar-mode t)
(setq-default tab-width 2)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(global-hl-line-mode 1)
;; (set-face-attribute 'hl-line nil :foreground nil)
(global-display-line-numbers-mode 1)

(setq-default cursor-type 'bar)


(add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
(global-auto-highlight-symbol-mode t)

;; (define-key global-map (kbd "C-;") 'comment-line)

(defun end-of-line-and-indented-new-line ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(define-key global-map (kbd "C-o") 'end-of-line-and-indented-new-line)
;; (define-key global-map (kbd "C-.") 'find-file)
(define-key global-map (kbd "C-z") 'undo)
(define-key global-map (kbd "C-x C-e") 'end-of-buffer)
(define-key global-map (kbd "C-x e") 'end-of-buffer)
(define-key global-map (kbd "C-x C-a") 'beginning-of-buffer)
(define-key global-map (kbd "C-x a") 'beginning-of-buffer)

(define-key global-map (kbd "C-j") 'comment-line)


(setq make-backup-files nil) ; stop creating ~ files

;; use company instead of this
;; (global-corfu-mode)
;; (corfu-popupinfo-mode)
;; (setq corfu-terminal t)
;; (add-to-list 'completion-at-point-functions #'cape-file)
;; (add-to-list 'completion-at-point-functions #'cape-dabbrev)


(global-hl-line-mode 1)
(set-face-attribute 'hl-line nil :foreground nil)

(defun xah-select-line ()
  (interactive)
  (if (region-active-p)
      (if visual-line-mode
          (let ((xp1 (point)))
            (end-of-visual-line 1)
            (when (eq xp1 (point))
              (end-of-visual-line 2)))
        (progn
          (forward-line 1)
          (end-of-line)))
    (if visual-line-mode
        (progn (beginning-of-visual-line)
               (push-mark (point) t t)
               (end-of-visual-line))
      (progn
        (push-mark (line-beginning-position) t t)
        (end-of-line)))))

(global-set-key (kbd "C-l") 'xah-select-line)

(defun xah-forward-block (&optional n)
  (interactive "p")
  (let ((n (if (null n) 1 n)))
    (re-search-forward "\n[\t\n ]*\n+" nil "NOERROR" n)))

(global-set-key (kbd "M-n") 'xah-forward-block)

(defun xah-backward-block (&optional n)
  "Move cursor to previous text block.
See: `xah-forward-block'
URL `http://xahlee.info/emacs/emacs/emacs_move_by_paragraph.html'
Version 2016-06-15"
  (interactive "p")
  (let ((n (if (null n) 1 n))
        ($i 1))
    (while (<= $i n)
      (if (re-search-backward "\n[\t\n ]*\n+" nil "NOERROR")
          (progn (skip-chars-backward "\n\t "))
        (progn (goto-char (point-min))
               (setq $i n)))
      (setq $i (1+ $i)))))

(global-set-key (kbd "M-p") 'xah-backward-block)

(require 'multiple-cursors)

(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; (global-set-key (kbd "C-i") 'kill-ring-save)


;; https://stackoverflow.com/questions/28221079/ctrl-backspace-in-emacs-deletes-too-much
;; https://www.reddit.com/r/emacs/comments/2ny06e/delete_text_not_kill_it_into_killring/
(defun my-delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument, do this that many times.
This command does not push erased text to kill-ring."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

;; (defun my-backward-delete-word (arg)
;;   "Delete characters backward until encountering the beginning of a word.
;; With argument, do this that many times.
;; This command does not push erased text to kill-ring."
;;   (interactive "p")
;;   (my-delete-word (- arg)))

;; (global-set-key [C-backspace] 'my-backward-delete-word)

;; (defun le/backward-delete-word (arg)
;;   (interactive "p")
;;   (delete-region (point) (progn (my-backward-word-or-other arg) (point))))

(defun previous-line-end-position-from (pos) 
  (save-excursion
    (goto-char pos)
    (forward-line -1)
    (end-of-line)
    (point)))
  
(defun le/backward-kill-word-stop-at-newline (arg)
  (interactive "p")
  (let (
        (start (point))
        (stop nil)
        (line-start (line-beginning-position))
       )
    ;; (forward-word -1)
    (my-backward-word-or-other arg)
    (setq stop (point))
    
    (if (save-excursion
            (goto-char start)
            (re-search-backward "\n" stop t))
      ;; (setq stop (line-beginning-position 0)))
        ;; then
        (progn 
          (setq stop (previous-line-end-position-from line-start))
          ;; (goto-char (previous-line-end-position-from line-start))
          (delete-region start stop)
          (goto-char stop)
          
        )
      ;; else
        (delete-region start stop)
      )))

(global-set-key [C-backspace] 'le/backward-kill-word-stop-at-newline)

(defun move-text-internal (arg)
  (cond
   ((and mark-active transient-mark-mode)
    (if (> (point) (mark))
        (exchange-point-and-mark))
    (let ((column (current-column))
          (text (delete-and-extract-region (point) (mark))))
      (forward-line arg)
      (move-to-column column t)
      (set-mark (point))
      (insert text)
      (exchange-point-and-mark)
      (setq deactivate-mark nil)))
   (t
    (let ((column (current-column)))
      (beginning-of-line)
      (when (or (> arg 0) (not (bobp)))
        (forward-line)
        (when (or (< arg 0) (not (eobp)))
          (transpose-lines arg))
        (forward-line -1))
      (move-to-column column t)))))

(defun move-text-down (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines down."
  (interactive "*p")
  (move-text-internal arg))

(defun move-text-up (arg)
  "Move region (transient-mark-mode active) or current line
  arg lines up."
  (interactive "*p")
  (move-text-internal (- arg)))

(provide 'move-text)

(global-set-key (kbd "C-S-P") 'move-text-up)
(global-set-key (kbd "C-S-N") 'move-text-down)

(global-set-key (kbd "<M-up>") 'move-text-up)
(global-set-key (kbd "<M-down>") 'move-text-down)


;; ;; use eglot instead
;; language servers
(require 'lsp)
(require 'lsp-haskell)
;; Hooks so haskell and literate haskell major modes trigger LSP setup
(add-hook 'haskell-mode-hook #'lsp)
(add-hook 'haskell-literate-mode-hook #'lsp)


(defun haskell-format-buffer-with-ormolu ()
  "Format the current Haskell buffer using ormolu."
  (interactive)
  (unless (buffer-modified-p)
    (save-excursion
      (shell-command-on-region (point-min) (point-max) "ormolu" (current-buffer) t))))


(add-hook 'haskell-mode-hook
          (lambda ()
            (add-hook 'before-save-hook 'haskell-format-buffer-with-ormolu nil t)))


;; auto-complete
(add-hook 'interactive-haskell-mode-hook 'ac-haskell-process-setup)
(add-hook 'haskell-interactive-mode-hook 'ac-haskell-process-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'haskell-interactive-mode))


(define-key global-map (kbd "C-x p") 'previous-buffer)
(define-key global-map (kbd "C-x n") 'next-buffer)
(define-key global-map (kbd "C-x C-p") 'previous-buffer)
(define-key global-map (kbd "C-x C-n") 'next-buffer)

(define-key global-map (kbd "C-M-]") 'term-toggle-shell)
(define-key global-map (kbd "C-`") 'term-toggle-shell)

(define-key global-map (kbd "C-s") 'swiper-thing-at-point)
;; (define-key global-map (kbd "C-s") 'save-buffer)

(define-key global-map (kbd "C-k") 'kill-line)
(define-key global-map (kbd "M-k") 'kill-region)
(global-set-key (kbd "TAB") 'tab-to-tab-stop)
(setq-default indent-tabs-mode nil)
								
;; (global-whitespace-mode 1)

;; https://emacs.stackexchange.com/questions/26417/custom-c-arrow-cursor-movement
;; (setq separators-regexp "[\-'\"();:,.\\/?!@#%&*+=\([:blank:]*\)]")
(setq separators-regexp "['\"();:,.\\/!@#%&*+=]")
(defun forward-to-separator()
    "Move to the next separator like in the every NORMAL editor"
    (interactive)
    (let ((my-pos (re-search-forward separators-regexp)))
        (goto-char my-pos)))

(defun backward-to-separator()
    "Move to the previous separator like in the every NORMAL editor"
    (interactive)
    (let ((my-pos (re-search-backward separators-regexp)))
        (goto-char my-pos)))


(defun my-backward-word-or-other (&optional n)
  "Move over the preceding word or non-word characters."
  (interactive "p")
  (unless (bobp)
    (if (eq ?w (char-syntax (char-before)))
        (backward-word)
      (skip-syntax-backward "^w"))))

(defun my-forward-word-or-other ()
  "Move over the following word or non-word characters."
  (interactive)
  (unless (eobp)
    (if (eq ?w (char-syntax (char-after)))
        (forward-word)
      (skip-syntax-forward "^w"))))


;; (global-set-key (kbd "C-<right>") 'forward-to-separator)
;; (global-set-key (kbd "C-<left>") 'backward-to-separator)
;; (global-set-key (kbd "M-f") 'forward-to-separator)
;; (global-set-key (kbd "M-b") 'backward-to-separator)


(global-set-key (kbd "C-<right>") 'my-forward-word-or-other)
(global-set-key (kbd "C-<left>") 'my-backward-word-or-other)
(global-set-key (kbd "M-f") 'my-forward-word-or-other)
(global-set-key (kbd "M-b") 'my-backward-word-or-other)


(ivy-mode t)
(company-mode t)  ;; auto-completion
(add-hook 'after-init-hook 'global-company-mode)

;; ;; use lsp instead
;; (add-hook 'haskell-mode-hook 'eglot-ensure)
;; (add-hook 'haskell-cabal-mode-hook 'eglot-ensure)
;; (add-hook 'racket-mode-hook 'eglot-ensure)


(setopt ivy-use-selectable-prompt t)
(global-git-gutter-mode +1)

(unless (file-exists-p "~/.emacs.d/tmp/tramp-autosaves/")
  (make-directory "~/.emacs.d/tmp/tramp-autosaves/" t))
(setq tramp-auto-save-directory "~/.emacs.d/tmp/tramp-autosaves/")


;; (defun kb-scroll-up-hold-cursor ()
;;   "Scroll up one position in file."
;;   (interactive)
;;   (scroll-up-command 1))

;; (defun kb-scroll-down-hold-cursor ()
;;   "Scroll down one position in file."
;;   (interactive)
;;   (scroll-up-command -1))

;; (defun kb-scroll-up ()
;;   "Scroll up one position in file, move cursor with the scroll."
;;   (interactive)
;;   (scroll-up-command -1)
;;   (forward-line -1))

;; (defun kb-scroll-down ()
;;   "Scroll down one position in file, move cursor with the scroll."
;;   (interactive)
;;   (scroll-up-command 1)
;;   (forward-line 1))

;; ;; (bind-key "C-M-P"  'kb-scroll-up-hold-cursor)
;; ;; (bind-key "C-M-N"  'kb-scroll-down-hold-cursor)

;; (global-set-key (kbd "<C-M-up>") 'kb-scroll-up-hold-cursor)
;; (global-set-key (kbd "<C-M-down>") 'kb-scroll-down-hold-cursor)

(setq inhibit-startup-screen t)
