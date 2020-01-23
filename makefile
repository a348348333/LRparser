bison -d hw2.y
flex hw2.l
gcc lex.yy.c hw2.tab.c
X= true and (false or false);
Y= false and true or true;
Cat= (false or true) and X or (false or true);
X= X or Y or Cat

sea = false;
fish = true;
dog= true or fish of sea
