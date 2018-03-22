#include <stdio.h>
#include <string.h>


char some_func(char *a, char *b, int n, char now){
  for(int i = 0; i < n; i++){
    if(a[i] == now)return b[i];
  }
  return now;
}


int main(void){
  char a[4096];
  char b[4096];
 
  scanf("%s %s", a, b);

  if(strlen(a) != strlen(b))return 0;

  int len = strlen(a);

  int n;
  scanf("%d", &n);

  for(int i = 0; i < n; i++){
    char c[4096];

    scanf("%s", c);

    int now_len = strlen(c);

    for(int j = 0; j < now_len; j++){
      char now = some_func(a, b, len, c[j]);
      printf("%c", now);
    }
    printf("\n");

  }

}
