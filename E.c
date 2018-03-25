#include <stdio.h>


int read_number(int *c, int *znk){
  int size = 0;

  for(int i = 0;;i++){
    char now;
    scanf("%c", &now);
    size++;

    if(now == '-'){
      *znk *= -1;
      size--;
      i--;
      continue;
    }
    if(now == '\n' || now ==' '){
      break;
    }
    c[i] = now - '0';
  }

  size --;
  for(int i = 0; i < size / 2; i++){
    int tmp = c[i];
    c[i] = c[size - i - 1];
    c[size - i - 1] = tmp;
  }

  return size;
}


void pros(int *a, int *b, int *res, int a_size, int b_size){
  for(int i = 0; i < a_size; i++){
    for(int j = 0; j < b_size; i++){
      int now = a[i] * b[i];

      res[i + j] += now % 10;
      res[i + j + 1] = res[j + i] / 10 + now / 10;
    }
  }
}



void print_num(int *a, int n){
  for(int i = 0; i < n; i++){
    printf("%d", a[i]);
  }
  printf("\n");
}


int main(){
  int znk = 1;

  int a[11];
  int b[11];
  int c[11];

  int a_size = read_number(a, &znk);
  int b_size = read_number(b, &znk);
  int c_size = read_number(c, &znk);


  int res[30];
  pros(a, b, res, a_size, b_size);

  print_num(res, 30);

  printf("%d %d %d %d\n", a_size, b_size, c_size, znk);

  print_num(a, a_size);
  print_num(b, b_size);
  print_num(c, c_size);
}
