#lang racket

; (define version "5.4.0")
(define version "5.2.2")
(define (join-path x1 x2) (string-append x1 "/" x2))

(define siesta-dir (string-append "siesta-" version))
(define build-dir (join-path siesta-dir "build"))

(system (string-append
  "wget -c https://gitlab.com/siesta-project/siesta/-/releases/" version "/downloads/siesta-" version ".tar.gz"))
(system (string-append
  "tar xzvf siesta-" version ".tar.gz"))
(system "apt-get install -y gfortran pkg-config libblas-dev liblapack-dev libreadline-dev cmake libomp-dev")

(if (directory-exists? build-dir)
  ; then
  '()
  ; else
  (make-directory build-dir)
)

(system (string-append 
  "cd " siesta-dir
  " && "
  "cmake -S. -B_build -DCMAKE_INSTALL_PREFIX=./build -DBLAS_LIBRARY=blas -DBLAS_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu -DLAPACK_LIBRARY=lapack -DLAPACK_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu -DSIESTA_WITH_OPENMP=ON"
  " && "
  "cmake --build _build -j4"
  " && "
  "cmake --install _build"
))
