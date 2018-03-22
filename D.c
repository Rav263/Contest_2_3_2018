#include <stdio.h>


int step(int n, int k){
  int res = 1;
  for(int i = 0; i < n; i++){
    res *= k;
   // res %= 2011;
  }

  return res;
}

/*void print_ink(int number, int k){
  for(int i = 0; number != 0; i++){
    printf("%d", number % k);
    number /= k;
  }
  printf("\n");
}*/

int count_num(int number, int k){
  int counter = 0;
  for(int i = 0; number != 0; i++){
    counter ++;
    number /= k;
  }

  return counter;
}


unsigned rec(int n, int k, unsigned a){
  if(n == 0)return a % 2011;
  if(n == 1){
    int now = rec(n - 1, k, a);

    int coun = count_num(now, k);
    int st = step(coun, k);

    return ((now * st) % 2011 + now) % 2011;
  }

  unsigned now_a = rec(n - 1, k, a);
  unsigned now_b = rec(n - 2, k, a);
  //print_ink(now_a, k);
  //print_ink(now_b, k);
  
  int coun = count_num(now_b, k);;

  int st = step(coun, k);
  //printf("%d %d\n",st, coun); 

  unsigned some = ((now_a * st) % 2011 + now_b) % 2011;

  //print_ink(some, k);;

  //printf("\n");

  return some;
}


int main(void){
  int n, k, a;

  scanf("%d %d %d", &k, &n, &a);

  printf("%d\n", rec(n, k, a));

  return 0;
}
