#include <stdio.h>
#include <SWI-Prolog.h>

int main()
{
  char *argv[] = {"hello", "-q"};
  PL_initialise(2, argv);

  term_t a = PL_new_term_refs(3);
  PL_put_integer(a, 11); // First argument to between/3
  PL_put_integer(a+1, 17); // Second argument to between/3

  static predicate_t p;
  if(!p)
    p = PL_predicate("between", 3, NULL) ; // predicate between/3

  qid_t q = PL_open_query(NULL, PL_Q_NORMAL, p, a);
  int tmp;
  while(PL_next_solution(q)==TRUE){
    PL_get_integer(a+2, &tmp); // Third argument to between/3
    printf("%d\n", tmp);
  }
  PL_close_query(q);
  return 0;
}
