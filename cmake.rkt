#lang racket 
;;3.12.3
(system "wget -c https://cmake.org/files/v4.1/cmake-4.1.1.tar.gz")
(system "tar zxvf cmake-4.*")
(system "cd cmake-4.1.1/ && ./bootstrap --prefix=/usr/local -DCMAKE_USE_OPENSSL=OFF && make -j$(nproc) && make install")

