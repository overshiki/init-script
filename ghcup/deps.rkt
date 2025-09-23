#lang racket 

(define sys "none")
(define country "none")
(command-line
 #:program "emacs-install"
 #:once-each
 [("-s") s "system" (set! sys s)]
 [("-c") c "country" (set! country c)]
 )

(match sys
  ("ubuntu"
   (begin
     (display "ubuntu linux")
     (system "sudo apt-get install -y libgmp-dev")))
  ("rocky"
   (begin
     (display "rocky linux")
     (system "sudo yum install -y gmp-devel")))
  (_
   (display "system not recognized")))

(match country
  ("china"
   (system
    "curl --proto '=https' --tlsv1.2 -sSf https://mirrors.ustc.edu.cn/ghcup/sh/bootstrap-haskell | BOOTSTRAP_HASKELL_YAML=https://mirrors.ustc.edu.cn/ghcup/ghcup-metadata/ghcup-latest.yaml sh"
    )
   )
  (_
   (system 
    "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
    )
   )
)


