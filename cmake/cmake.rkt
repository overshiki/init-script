#lang racket
(require "../lib.rkt")

(require racket/cmdline)
(require racket/match)
(require data/maybe)

(match (get-os)
  ['ubuntu '()]
  [_ (raise "currently only support ubuntu")])

(apt-get "openssl")

;; (define sys "none")
(define version "none")
(command-line
 #:program "cmake-install"
 #:once-each
 ;; [("-s") s "system" (set! sys s)]
 [("-v") v "3.12.3" (set! version v)]
)

(define version-list
  (list
    "3.12.3"
    "4.1.1"))

(define/match (get-src-dir v)
  [("3.12.3") "3.12"]
  [("4.1.1") "4.1"])

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

;;3.12.3
(wget (string-append "https://cmake.org/files/v" (get-src-dir version) "/cmake-" version ".tar.gz"))
(system (string-append "tar zxvf cmake-" version ".tar.gz"))

(system 
(chain
 (string-append "cd cmake-" version)
 "./configure --prefix=/usr/local"
 "make -j$nproc"
 "make install"))

;; (system "cd cmake-4.1.1/ && ./configure --prefix=/usr/local -DCMAKE_USE_OPENSSL=OFF && make -j$(nproc) && make install")
;; (system "cd cmake-4.1.1/ && ./bootstrap --prefix=/usr/local && make -j$(nproc) -DCMAKE_USE_OPENSSL=OFF && make install")
