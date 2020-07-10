function compile {
  file=${1}
  cython "$file.pyx"  -3 -Wextra -D
  cmd="gcc-7 $file.c `python3-config --cflags --ldflags --includes --libs` -fno-lto -pthread -fPIC -fwrapv -pipe -march=native -mtune=native -Ofast -msse2 -msse4.2 -shared -o $file.so"
  echo "Executing $cmd"
  $cmd
  echo "Testing compilation.."
  python3 -c "import $file"
  echo
}

compile observation_utils
compile rail_env