make

cd test/build
cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=1
make

echo "===== < TEST > ====="
./test
printf "===== < %3s  > =====\n" $?

