#lang racket
(provide chain)

(define (chain . xs)
  (define (fchain xs)
    (match xs
     [(cons x '()) x]
     [(cons x xxs)
            (string-append x " && " (fchain xxs))]
     ['() "" ]
     ))
  (fchain xs)
)
