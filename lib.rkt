#lang racket
(provide chain)
(provide wget)
(provide apt-get)
(provide yum-install)
(provide mkdir)

(define (string-chain sep xs)
  (match xs
    [(cons x '()) x]
    [(cons x xxs)
     (string-append x sep (string-chain sep xxs))]
    ['() ""]
    ))

(define (chain . xs)
  (string-chain " && " xs))

(define (wget link)
  (system
   (string-append "wget -c " link)))

(define (apt-get . xs)
  (system
   (string-append
    "apt-get install -y "
    (string-chain " " xs))))

(define (yum-install . xs)
  (system
   (string-append
    "yum install -y "
    (string-chain " " xs))))

(define (mkdir build-dir)
  (if (directory-exists? build-dir)
      ; then
      '()
      ; else
      (make-directory build-dir)))
