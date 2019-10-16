file="$(mktemp -u).cpp"
touch "$file"

data="$1"
shift

printf "%s\n" $'#include <iostream>' >> $file
printf "%s\n" $'#include "include/types.h"' >> $file
printf "%s\n" $'#include "'"$data"$'"' >> $file
printf "%s\n" $'int main () {' >> $file

for arg in "$@"
do
	printf "%s\n" $'\tstd::cout << "'"$arg"$'";' >> $file
	printf "%s\n" $'\tfor (int i = 0; i < (sizeof('"$arg"$') / sizeof('"$arg"$'[0])); i++) {' >> $file
	printf "%s\n" $'\t\tstd::cout << " " << '"$arg"$'[i];' >> $file
	printf "%s\n" $'\t}' >> $file
	printf "%s\n" $'\tstd::cout << std::endl;' >> $file
done

printf "%s\n" $'\treturn 0;' >> $file
printf "%s\n" $'}' >> $file

g++ -I. $file

rm $file
