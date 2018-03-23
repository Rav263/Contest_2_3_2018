#include <stdio.h>
#include <string.h>


char some_func(char *a, char *b, int n, char now){
  char ret = now;
  for(int i = 0; i < n; i++){
    if(a[i] == now)ret = b[i];
  }
  return ret;
}


void read_string(char *str){
  for(int i = 0;;i++){
    char now;
    scanf("%c", &now);
    if(now == '\n'){
      str[i] = '\0';
      break;
    }
    str[i] = now;
  }
}


int main(void){
  char a[10000];
  char b[10000];
 
  read_string(a);
  read_string(b);

  if(strlen(a) != strlen(b))return 0;

  int len = strlen(a);

  int n;
  char now;
  scanf("%d", &n);
  scanf("%c", &now);

  for(int i = 0; i < n; i++){
    char c[10000];

    read_string(c);
    int now_len = strlen(c);


    for(int j = 0; j < now_len; j++){
      c[j] = some_func(a, b, len, c[j]);
    }
    printf("%s\n", c);

  }
  return 0;
}
