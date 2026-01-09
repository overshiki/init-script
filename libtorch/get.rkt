#lang racket

;; latest
;; (system "wget -c https://download.pytorch.org/libtorch/nightly/cpu/libtorch-shared-with-deps-latest.zip")
;; (system "wget -c https://download.pytorch.org/libtorch/nightly/cpu/libtorch-shared-with-deps-latest.zip")


;; 2.7.0
(define link "https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-2.7.0%2Bcpu.zip")
(define zip "libtorch-cxx11-abi-shared-with-deps-2.7.0+cpu.zip")
(when (not (file-exists? zip))
  (system (string-append
           "wget -c "
           link)
           )
  )

  
(system (string-append "unzip " zip))

