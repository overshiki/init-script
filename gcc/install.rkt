#lang racket
(require "../lib.rkt")
(require racket/cmdline)
(require racket/match)

(define sys "none")
(define version "none")
(command-line
 #:program "emacs-install"
 #:once-each
 [("-s") s "system" (set! sys s)]
 [("-v") v "15.2.0" (set! version v)]
)

;; (match version
;;   ("15.2.0" '())
;;   ("11.4.0" '())
;;   ("10.1.0" '())
;;   ("14.1.0" '())
;;   (_ (raise "use -v to set version; currently supported versions are: 15.2.0 11.4.0 10.1.0" #t)))

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
  ("ubuntu"
   (begin
     (display "ubuntu linux")
     (system "apt-get install -y libgmp-dev libmpc-dev libmpfr-dev")
     ))
  ("rocky"
   (begin
     (display "rocky linux")
     (system "yum install -y gmp-devel libmpc libmpc-devel mpfr-devel gcc-c++")
     ))
  (_
   (display "system not recognized")))
  
(system (string-append "wget -c " gcc-link))
(if (directory-exists? gcc-name)
    '()
    (system (string-append "tar -xvf " gcc-tar)))

(system
  (chain
    (string-append "cd " gcc-name)
    "./configure --disable-multilib"
    "make -j$nproc"))

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
