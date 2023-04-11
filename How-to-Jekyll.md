# How to Jekyll

This site is built with Jekyll

## Installation steps
Installation instructions in: https://jekyllrb.com/docs/installation/


### Check requirements

I am using Solus Linux, so I check the installation of Ruby development libraries with `sudo eopkg list-available | grep ruby`, and then install them with:

```sh
sudo eopkg install ruby-devel
```

My version of Ruby is `ruby -v`:

```sh
ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]
```
With Gems `gems -v`
```sh
3.3.7
```

My version of GCC and Make is `gcc -v`, `g++ -v` and `make -v`:
```sh
Using built-in specs.
COLLECT_GCC=gcc
COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-solus-linux/12/lto-wrapper
Target: x86_64-solus-linux
Configured with: ../configure --prefix=/usr --with-pkgversion=Solus --libdir=/usr/lib64 --libexecdir=/usr/lib64 --with-system-zlib --enable-cet --enable-default-pie --enable-default-ssp --enable-lto --enable-shared --enable-threads=posix --enable-gnu-indirect-function --enable-__cxa_atexit --enable-plugin --enable-gold --enable-ld=default --enable-clocale=gnu --enable-multilib --with-multilib-list=m32,m64 --with-gcc-major-version-only --with-bugurl=https://dev.getsol.us/ --with-build-config=bootstrap-lto-lean --with-arch_32=i686 --enable-linker-build-id --with-linker-hash-style=gnu --with-gnu-ld --build=x86_64-solus-linux --target=x86_64-solus-linux --enable-languages=c,c++,fortran,ada
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.2.0 (Solus) 
```

```sh
Using built-in specs.
COLLECT_GCC=g++
COLLECT_LTO_WRAPPER=/usr/lib64/gcc/x86_64-solus-linux/12/lto-wrapper
Target: x86_64-solus-linux
Configured with: ../configure --prefix=/usr --with-pkgversion=Solus --libdir=/usr/lib64 --libexecdir=/usr/lib64 --with-system-zlib --enable-cet --enable-default-pie --enable-default-ssp --enable-lto --enable-shared --enable-threads=posix --enable-gnu-indirect-function --enable-__cxa_atexit --enable-plugin --enable-gold --enable-ld=default --enable-clocale=gnu --enable-multilib --with-multilib-list=m32,m64 --with-gcc-major-version-only --with-bugurl=https://dev.getsol.us/ --with-build-config=bootstrap-lto-lean --with-arch_32=i686 --enable-linker-build-id --with-linker-hash-style=gnu --with-gnu-ld --build=x86_64-solus-linux --target=x86_64-solus-linux --enable-languages=c,c++,fortran,ada
Thread model: posix
Supported LTO compression algorithms: zlib zstd
gcc version 12.2.0 (Solus) 
```

and

```sh
GNU Make 4.3
Built for x86_64-solus-linux-gnu
Copyright (C) 1988-2020 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
```

### Gem installation path

```sh
echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Install Jekyll and Bundler
With Ruby installed, install Jekyll from the terminal:
```sh
gem install jekyll bundler
```


## Run local instance
Go to project directory. Create a new `Gemfile` to list your project’s dependencies:

```sh
bundle init
```

Edit the `Gemfile` in a text editor and add jekyll as a dependency:

```sh
echo "gem \"jekyll\"" >> Gemfile
```
Run `bundle` to install jekyll for your project.

We now prefix all jekyll commands with `bundle exec` to make sure we use the jekyll version defined in the Gemfile.
