#include <stdio.h>

int some(int number){
  int sum = 0;
  for(int i = 1; i < number; i++){
    if(number % i == 0) sum += i;
  }
  return sum < number;
}

int main(void){
  int k;

  scanf("%d", &k);

  int counter = 0;
  int now_number = 0;

  for(int i = 1;counter < k;i++){
    if(some(i)){
      counter++;
      now_number = i;
    }
  }

  printf("%d\n", now_number);
}
