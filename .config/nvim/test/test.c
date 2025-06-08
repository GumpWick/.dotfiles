

#include <stdlib.h>
int main(int argc, char *argv[]){
  int t[argc-1];
  
  for (int i = 0; i < argc; ++i){
    t[i-1] = atoi(argv[i]);
  }

  return 0;
}
