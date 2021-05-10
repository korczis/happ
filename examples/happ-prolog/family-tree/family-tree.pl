/* Facts */
male("jakub-korcak").
male("tomas-korcak").
male("pavel-korcak").
male("petr-korcak").
male("stepan-korcak").
female("alena-korcakova").
female("eva-korcakova").

parent_of("pavel-korcak", "eva-korcakova").
parent_of("petr-korcak", "eva-korcakova").

parent_of("tomas-korcak", "pavel-korcak").
parent_of("tomas-korcak", "alena-korcakova").

parent_of("jakub-korcak", "pavel-korcak").
parent_of("jakub-korcak", "alena-korcakova").

/* Rules */
father_of(X, Y):- male(X),
    parent_of(X, Y).

mother_of(X, Y):- female(X),
    parent_of(X, Y).

/* Entrypoint */
main :-
    format('Family ~n'),
    halt.