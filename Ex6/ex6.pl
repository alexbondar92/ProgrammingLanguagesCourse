/*Anastasia Neiman 313103400 Anastasiane@campus*/
/*Alex Bondar 311822258 Alex.bondar@campus*/

/***
@descr Family rules.
@author Tomer
@date Long time ago
*/

diff(X, Y) :- when(?=(X,Y), X \== Y). 


/**
@form male(Name).
@constraints
  @unrestricted Name.
@descr Person with Name is a male.
*/
male(terah).
male(haran).
male(lot).
male(abraham).
male(ishmael).
male(isaac).
male(bethuel).
male(laban).
male(jacob).
male(iscah).
male(esau).
male(reuben).
male(simeon).
male(levi).
male(judah).
male(dan).
male(naphtali).
male(gad).
male(asher).
male(issachar).
male(zebulun).
male(joseph).
male(benjamin).
male(tomer).
male(nahor).


/**
@form female(Name).
@constraints
  @unrestricted Name.
@descr Person with Name is a female.
*/
female(sarah).
female(hagar).
female(milcah).
female(rebecca).
female(leah).
female(rachel).
female(bilhah).
female(zilpah).
female(dinah).

/**
@form parent(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is the parent of person with Name2.
*/
parent(terah, abraham).
parent(terah, sarah).
parent(terah, haran).
parent(terah, nahor).
parent(nahor, bethuel).
parent(haran, lot).
parent(haran, milcah).
parent(haran, iscah).
parent(milcah, bethuel).
parent(abraham, isaac).
parent(abraham, ishmael).
parent(bethuel,rebecca).
parent(bethuel,laban).
parent(isaac, jacob).
parent(isaac, esau).
parent(laban, rachel).
parent(laban, leah).
parent(sarah, isaac).
parent(hagar, ishmael).
parent(rebecca, jacob).
parent(rebecca, esau).
parent(jacob, dinah).
parent(jacob, reuben).
parent(jacob, simeon).
parent(jacob, levi).
parent(jacob, judah).
parent(jacob, dan).
parent(jacob, naphtali).
parent(jacob, gad).
parent(jacob, asher).
parent(jacob, issachar).
parent(jacob, zebulun).
parent(jacob, joseph).
parent(jacob, benjamin).
parent(leah, dinah).
parent(leah, reuben).
parent(leah, simeon).
parent(leah, levi).
parent(leah, judah).
parent(bilhah, dan).
parent(bilhah, naphtali).
parent(zilpah, gad).
parent(zilpah, asher).
parent(leah, issachar).
parent(leah, zebulun).
parent(rachel, joseph).
parent(rachel, benjamin).

/**
@form mother(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is the mother of person with Name2.
*/
mother(X,Y):-female(X),parent(X,Y).

/**
@form father(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is the father of person with Name2.
*/
father(X,Y):-male(X),parent(X,Y).

/**
@form son(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is the son of person with Name2.
*/
son(X,Y):-male(X),parent(Y,X).

/**
@form daughter(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is the daughter of person with Name2.
*/
daughter(X,Y):-female(X),parent(Y,X).

/**
@form spouse(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a spouse (has a child with)  of person with Name2.
*/
spouse_d(X,Y):-parent(X,Z),parent(Y,Z),male(X),female(Y).
spouse_d(X,Y):-parent(X,Z),parent(Y,Z),male(Y),female(X).

spouse(X,Y):-setof(X-Y,spouse_d(X,Y),List),member(X-Y,List).

/**
@form siblings(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a siblings of person with Name2.
*/
siblings_b(X,Y):-parent(Z,X),parent(Z,Y),diff(X,Y).

siblings(X,Y):-setof(X-Y,siblings_b(X,Y),List),member(X-Y,List).

/**
@form brother(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a brother of person with Name2.
*/
brother(X,Y):-male(X),siblings(X,Y).

/**
@form sister(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a sister of person with Name2.
*/
sister(X,Y):-female(X),siblings(X,Y).

/**
@form grandfather(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a grandparent of person with Name2.
*/
grandfather_b(X,Y):-male(X),parent(X,Z),parent(Z,Y).

grandfather(X,Y):-setof(X-Y,grandfather_b(X,Y),List),member(X-Y,List).

/**
@form grandmother(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a grandmother of person with Name2.
*/
grandmother_b(X,Y):-female(X),parent(X,Z),parent(Z,Y).

grandmother(X,Y):-setof(X-Y,grandmother_b(X,Y),List),member(X-Y,List).

/**
@form uncle(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is an uncle of person with Name2. Uncle is a male family relationship or kinship within an extended or immediate family. An uncle is the brother, half-brother, step-brother, or brother-in-law of one's parent, or the husband of one's aunt.
*/

/*uncle_b(X,Y):-male(X),siblings(X,Z),parent(Z,Y),male(Z),diff(Z,X).
uncle_b(X,Y):-male(X),spouse(X,Z),siblings(Z,T),parent(T,Y),diff(T,X).*/

uncle_b(X,Y):-brother(X,Z),parent(Z,Y).
uncle_b(X,Y):-parent(Z,Y),spouse(Z,T),brother(X,T).
uncle(X,Y):-setof(X-Y,uncle_b(X,Y),List),member(X-Y,List).


/*aunt_b(X,Y):-female(X),siblings(X,Z),parent(Z,Y).
aunt_b(X,Y):-female(X),spouse(X,Z),siblings(Z,T),parent(T,Y).*/

aunt_b(X,Y):-sister(X,Z),parent(Z,Y).
aunt_b(X,Y):-parent(Z,Y),spouse(Z,T),sister(X,T).

aunt(X,Y):-setof(X-Y,aunt_b(X,Y),List),member(X-Y,List).

/**
@form nephew(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a newphew of person with Name2.
*/
nephew(X,Y):-male(X),uncle(Y,X).
nephew(X,Y):-male(X),aunt(Y,X).

/**
@form cousin(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a cousin of person with Name2.
*/
/*cousin(X,Y):-uncle(Z,Y),parent(Z,X),diff(X,Y).*/
cousin_b(X,Y):-parent(Z,X),siblings(Z,T),parent(T,Y),diff(X,Y),not(siblings(X,Y)).

cousin(X,Y):-setof(X-Y,cousin_b(X,Y),List),member(X-Y,List).

/**
@form successor(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a successor of person with Name2.
*/
successor(X,Y):-ancestor(Y,X).

/**
@form ancestor(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is an ancestor of person with Name2.
*/
ancestor_b(X,Y):-parent(X,Y).
ancestor_b(X,Y):-parent(X,Z),ancestor_b(Z,Y).

ancestor(X,Y):-setof(X-Y,ancestor_b(X,Y),List),member(X-Y,List).

/**
@form familty(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is family (has any conaction of family tree) of person with Name2.
*/
family_b(X,Y):-ancestor(Z,X),ancestor(Z,Y),diff(X,Y).
family_b(X,Y):-successor(Z,X),successor(Z,Y),diff(X,Y).
family_b(X,Y):-ancestor(X,Y).
family_b(X,Y):-ancestor(Y,X).
family_b(X,Y):-successor(Z,X),ancestor(T,Z),successor(P,Y),ancestor(T,P).
family_b(X,Y):-successor(Z,X),ancestor(T,Z),ancestor(T,Y).
family_b(X,Y):-successor(Z,Y),ancestor(T,Z),ancestor(T,X).

family(X,Y):-setof(X-Y,family_b(X,Y),List),member(X-Y,List).

/**
@form bad_spouse(Name1, Name2).
@constraints
  @unrestricted Name1.
  @unrestricted Name2.
@descr Person with Name1 is a spouse of person with Name2 and they have the same ancestor.
*/
bad_spouse_b(X,Y):-male(X),female(Y),parent(X,Z),parent(Y,Z),ancestor(T,X),ancestor(T,Y).
bad_spouse_b(X,Y):-male(Y),female(X),parent(X,Z),parent(Y,Z),ancestor(T,X),ancestor(T,Y).

bad_spouse(X,Y):-setof(X-Y,bad_spouse_b(X,Y),List),member(X-Y,List).
