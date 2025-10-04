#lang racket 
(require "../lib.rkt")
(require racket/cmdline)
(require racket/match)
(require data/maybe)

;; (define sys "none")
(define version "none")
(command-line
 #:program "emacs-install"
 #:once-each
 ;; [("-s") s "system" (set! sys s)]
 [("-v") v "2.27" (set! version v)]
)

(define version-list
  (list
   "2.27"
   "2.34"
   ))

(if (elem? version version-list)
    '()
    (raise (string-append
            "use -v to set version; currently supported versions are: "
            (string-chain " " version-list))))

;; (match version
;;   ("2.27" '())
;;   ("2.34" '())
;;   (_ (raise "use -v to set version; currently supported versions are: ..." #t)))

(match (get-os)
  ['ubuntu (apt-get "bison" "gettext" "texinfo")]
  [_ (raise 'failed #t)])

;; (define version "2.27")
(define mirror "https://mirror.csclub.uwaterloo.ca/gnu/glibc/")
(define tar-file (string-append "glibc-" version ".tar.gz"))
(define dir (string-append "glibc-" version))

(wget (string-append mirror tar-file))
(system (string-append
         "tar zxvf "
         tar-file))

(mkdir (string-append dir "/build"))

(system (chain
         (string-append "cd " dir)
         "cd build"
         (string-append "../configure --prefix=/opt/" dir " --disable-werror")
         "make -j$nproc"
         ))

;; (system "wget http://ftp.gnu.org/gnu/glibc/glibc-2.27.tar.gz")
;; (system "tar zxvf glibc-2.27.tar.gz")
;; ;; for gcc newer than gcc-7, we need --disable-werror
;; ;; say https://elixir.bootlin.com/glibc/glibc-2.27/source/INSTALL
;; (system "cd glibc-2.27 && mkdir build && cd build && ../configure --prefix=/opt/glibc-2.27 --disable-werror")

