#include <stdio.h>
#include <SWI-Prolog.h>

void consult_file(const char* filename){
  /* PL_initialse before calling. */
  predicate_t p = PL_predicate("consult", 1, NULL);
  term_t a = PL_new_term_ref();
  PL_put_atom_chars(a, filename);
  PL_call_predicate(NULL, PL_Q_NORMAL, p, a);
}

int main()
{
  char* argv[] = {"consult_file", "-q"};
  PL_initialise(2, argv);
  consult_file("digits.pl"); /* Load prolog file */

  static predicate_t p;
  /* third argument is module name if the predicate is in one.*/
  if(!p) p= PL_predicate("digit", 1, NULL); 
  int tmp; term_t a = PL_new_term_ref();
  qid_t q = PL_open_query(NULL, PL_Q_NORMAL, p, a);
  while(PL_next_solution(q)==TRUE){ /* All solutions */
    PL_get_integer(a, &tmp);
    printf("%d\n ", tmp);
  }

  return PL_halt(0);
}
