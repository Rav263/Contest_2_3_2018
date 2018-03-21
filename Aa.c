#include <stdio.h>

unsigned step(int a){
  if(a == 0)return 1;
  return 3 * step(a - 1);
}


int main(void){
  int c;
  scanf("%d", &c);

  printf("%u\n", step(c));
  return 0;
}
