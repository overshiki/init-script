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
 [("-v") v "15.2.0" (set! version v)]
)

(define sys (get-os))

(define version-list
  (list
   "15.2.0"
   "14.1.0"
   "13.1.0"
   "12.1.0"
   "11.4.0"
   "10.1.0"))

(if (elem? version version-list)
    ;then
    '()
    ;else
    (raise (string-append
            "use -v to set version; currently supported versions are: "
            (string-chain " " version-list)
            "; but set: "
            version
            )))

(define gcc-name
  (string-append
   "gcc-" version))

(define gcc-tar
  (string-append
   gcc-name
   ".tar.xz"))

(define gcc-link
  (string-append
   "https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/"
   gcc-name
   "/"
   gcc-tar))

(match sys
  ('ubuntu
   (begin
     (display "ubuntu linux")
     (apt-get
      "libgmp-dev"
      "libmpc-dev"
      "libmpfr-dev")
     ))
  ('rocky
   (begin
     (display "rocky linux")
     (yum-install
      "gmp-devel"
      "libmpc"
      "libmpc-devel"
      "mpfr-devel"
      "gcc-c++")
     ))
  (_
   (display "system not recognized")))

(wget gcc-link)

(if (directory-exists? gcc-name)
    '()
    (system (string-append "tar -xvf " gcc-tar)))

(let ([nthreads-limit
      (let ([mem (memory)])
        (cond
          [(and (< mem 24) (>= mem 0))  (just 10)]
          [(and (< mem 48) (>= mem 24)) (just 20)]
          [else nothing]))])
  (match nthreads-limit
    [(just nth)
     (let ([threads (number->string (min nth (nproc)))])
     (system
       (chain
         (string-append "cd " gcc-name)
         "./configure --disable-multilib"
         (string-append "make -j" threads))))]
    [nothing (raise 'failed #t)]))

(system
 (chain
  (string-append "cd " gcc-name)
  "make install"))
(system
 (chain
  (string-append "cd " gcc-name)
  "make install-target-libstdc++-v3"))

;; to check libstdc++ version
;; /sbin/ldconfig -p | grep stdc++
;; strings /usr/lib/libstdc++.so.6 | grep LIBCXX
