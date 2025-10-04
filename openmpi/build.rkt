#lang racket
(require "../lib.rkt")

(match (get-os)
  ['ubuntu (apt-get "libpmix-dev")]
  [_ (raise 'failed #t)])

(wget "https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.8.tar.gz")
;; (system "wget -c https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.8.tar.gz")
(system "tar xzvf openmpi-5.0.8.tar.gz")
(system (chain
 (string-append "cd " "openmpi-5.0.8")
 "./configure"
 "make -j$nproc"
 "make install"))
