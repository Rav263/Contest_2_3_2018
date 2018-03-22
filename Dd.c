#include <stdio.h>
#include <stdlib.h>


int step(int n, int k){
  int res = 1;
  
  for(int i = 0; i < n; i++){
    res *= k;
    res %= 2011;
  }
  
  return res;
}


int count_num(int number, int k){
  int counter = 0;
  
  for(int i = 0; number != 0; i++){
    counter ++;
    number /= k;
  }

  return counter;
}


unsigned oper(unsigned a, unsigned b, int k){
  int coun = count_num(b, k);;

  int st = step(coun, k);
  
  return ((a * st) % 2011 + b) % 2011;
}

unsigned not_rec(int n, int k, unsigned a){
  unsigned *arr = malloc((n + 1) * sizeof(unsigned));

  arr[0] = a % 2011; 
  arr[1] = oper(a, a, k);

  for(int i = 2; i <= n; i++){
    arr[i] = oper(arr[i - 1], arr[i - 2], k);
  }

  unsigned some = arr[n];
  free(arr);

  return some;
}



int main(void){
  int n, k, a;

  scanf("%d %d %d", &k, &n, &a);

  printf("%d\n", not_rec(n, k, a));

  return 0;
}
