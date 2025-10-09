#lang racket

(define package-files
      '(
        ;; deps start 
        "popup"
        "dash"
        "ht"
        ;; pkgs start 
        "company"
        "multiple-cursors"
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

;; (define (is-tar-file? file)
;;   (let ([items (string-split file ".")])
;;     (string=? "tar" (last items))))

(define (startwith? prefix name)
  (let ([l (string-length prefix)]
        [ls (string-length name)]
        )
    (if (<= l ls)
        ;then
        (let ([sub (substring name 0 l)])
          (string=? sub prefix))
        ;else
        #f)))

(define (endwith? surfix name)
  (let ([l (string-length surfix)]
        [ls (string-length name)])
    (if (<= l ls)
        (let ([sub (substring name (- ls l))])
          (string=? sub surfix))
        #f)))

(define (is-tar-file? file)
  (endwith? ".tar" file))

(define (trim-surfix surfix name)
  (let ([l (string-length surfix)]
        [ls (string-length name)]
        )
    (substring name 0 (- ls l))))

(define (trim-prefix prefix name)
  (let ([l (string-length prefix)])
    (substring name l)))

(struct dir-file (dir file) #:transparent)

(define (list-tars dir)
  (let ([files (map path->string (directory-list dir))])
    (map (lambda (file) (dir-file dir file))
           (filter is-tar-file? files))))

(define (list-all-tars)
  (let ([root-dir "/root/mirror/"])
    (append
     (list-tars (string-append root-dir "melpa/"))
     (list-tars (string-append root-dir "gnu/"))
     )))

(define (is-number? x)
  (let ([xs (string-split x ".")])
    (andmap (lambda (xi) (not (eq? (string->number xi) #f))) xs)))

(define (is-match? prefix name)
  (if (startwith? prefix name)
      ;then
      (if (endwith? ".tar" name)
          ;then
          (let* ([x (trim-prefix prefix (trim-surfix ".tar" name))]
                 [xs (string-split x "-")])
            (andmap is-number? xs))
          ;else
          #f
          )
      ;else
      #f
      ))


(define (is-match-dir/file? prefix df)
  (match df
    [(dir-file dir file) (is-match? prefix file)]
    [_ (raise 'match-failed #t)]))

(define (find-tar-file prefix)
  (match
      (filter (lambda (name) (is-match-dir/file? prefix name))
              (list-all-tars))
    [(cons x nil)
     (match x
       [(dir-file dir file) (string-append dir file)]
       [_ (raise 'value-error-level1 #t)])]
    [xs (raise (format "value-error-level0 at: ~s with length: ~s" prefix (length xs))  #t)]))

(define (find-install name)
  (let* ([file (find-tar-file name)]
         [cmd (string-append
               "emacs --batch --eval '(package-install-file "
               "\""
               file
               "\""
               ")'")])
    (print cmd)
    (newline)
    (system cmd)
    ))

;; (find-install "popup")
;; emacs --batch --eval "(message (number-to-string (+ 2 3)))"

(for ([name package-files])
  (find-install name))
