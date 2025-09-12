#lang racket
;; (system "wget -c https://mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-15.2.0/gcc-15.2.0.tar.xz")
(system "tar -xvf gcc-15.2.0.tar.xz")
(system "apt-get install libgmp-dev libmpc-dev libmpfr-dev")
