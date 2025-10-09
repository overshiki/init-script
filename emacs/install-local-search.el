;; (package-install-file "deps/shadchen-el/shadchen.el")
;; (load "/root/init-script/emacs/deps/shadchen-el/shadchen.el")
;; (require 'shadchen)

;; (package-install-file "deps/emacs-term-toggle/term-toggle.el")

;; (setq package-list
;;       '(
;;         company
;;         multiple-cursors
;;         use-package
;;         auto-highlight-symbol
;;         auto-complete
;;         highlight-parentheses
;;         clipmon
;;         highlight-indent-guides
;;         swiper-helm
;;         lsp-haskell
;;         doom-themes
;;         go-mode
;;         haskell-mode
;;         futhark-mode
;;         racket-mode
;;         tuareg         ;;; ocaml
;;         julia-mode
;;         rust-mode
;;         markdown-mode
;;         elixir-mode
;;         scala-mode
;;         ))

(defun is-tar-file (file)
  (let ((items (split-string file "\\.")))
      (string= "tar" (car (last items))))
    )

(defun startwith (name prefix)
  (let* ((l (length prefix))
      (sub (substring name 0 l)))
    (string= sub prefix)))


;; (defun filter (pred alist)
;;   (match alist
;;          ((cons x xs) (if (funcall pred x)
;;                           (cons x (filter pred xs))
;;                           (filter pred xs)))
;;          (nil nil)))

(defun filter (pred alist)
  (pcase alist
    (`(,x . ,xs) (if (funcall pred x)
                     (cons x (filter pred xs))
                     (filter pred xs)))
    (`nil nil)
  ))

;; (print
;;   (filter (lambda (x) (string= "eq" x)) '("eq" "eeq" "eq"))
;;   )

(defun list-tars (dir)
  (let ((files (directory-files dir)))
    (filter 'is-tar-file files)))        

(defun list-all-tars ()
  (let ((root-dir "/root/mirror/"))
    (append
      (list-tars (concat root-dir "melpa/"))
      (list-tars (concat root-dir "gnu/"))
    )))


(print
  (filter (lambda (name) (startwith name "popup")) (list-all-tars))
  )

(setq package-files
      '(
        ;; deps start 
        "popup"
        "dash"
        "ht"
        ;; pkgs start 
        "company"
        "multiple"
        "use-package"
        "auto-highlight-symbol"
        "auto-complete"
        "highlight-parentheses"
        "clipmon"
        "highlight-indent-guides"
        ;; deps start
        "reformatter"
        "lv"
        "markdown-mode"
        "spinner"
        "s"
        "f"
        "lsp-mode"
        "wfnames"
        "async"
        "ivy"
        "swiper"
        "helm-core"
        "helm"
        ;; pkgs start 
        "swiper-helm"
        "lsp-haskell"
        "doom-themes"
        "go-mode"
        "haskell-mode"
        "futhark-mode"
        "racket-mode"
        ;; deps start
        "caml"
        ;; pkgs start 
        "tuareg"
        "julia-mode"
        "rust-mode"
        "elixir-mode"
        "scala-mode"
        )
      )


;; (dolist (package package-files)
;;   (package-install-file (concat "/root/mirror/" package)))
