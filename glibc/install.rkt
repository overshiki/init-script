#lang racket 
(system "wget http://ftp.gnu.org/gnu/glibc/glibc-2.27.tar.gz")
(system "tar zxvf glibc-2.27.tar.gz")
;; for gcc newer than gcc-7, we need --disable-werror
;; say https://elixir.bootlin.com/glibc/glibc-2.27/source/INSTALL
(system "cd glibc-2.27 && mkdir build && cd build && ../configure --prefix=/opt/glibc-2.27 --disable-werror")

