#include <stdio.h>


int nod(int a, int b){
  for(int i = 0;b != 0 && a != 0; i++){
    if(a < b){
      b %= a;
    }else{
      a %= b;
    }
  }
  return a + b;
}

int nok(int a, int b){
   return (a * b)/nod(a, b);
}


int main(void){
  int n;
  scanf("%d", &n);

  int all_x = 0;
  int all_y = 0;
  scanf("%d %d", &all_x, &all_y);


  for(int i = 1; i < n; i++){
    int x, y;

    scanf("%d %d", &x, &y);
    
    int now = nok(y, all_y);

    all_x *= (now / all_y);
    x     *= (now / y);

    all_x += x;
    all_y = now;
  }

  int now = nod(all_x, all_y);

  all_x /= now;
  all_y /= now;

  printf("%d %d\n", all_x, all_y);

  return 0;
}
