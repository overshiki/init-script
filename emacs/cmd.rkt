#lang racket
(require racket/cmdline)
(define repeat 1)
(define msg "default")
(command-line
#:program "cli-demo"
#:once-each
[("-n") n "repeat count" (set! repeat (string->number n))]
#:args (text) (set! msg text))
(for ([i (in-range repeat)]) (displayln msg))
