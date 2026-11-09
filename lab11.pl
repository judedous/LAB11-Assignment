 % Database
   :- dynamic letters/1.

letters([a,b,c]).

% Start the program
start :-
    retractall(letters(_)),
    assertz(letters([a,b,c])),
    nl,
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

% Menu
menu :-
    nl,
   write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice: '),

    read(Choice),
    execute(Choice).

% Option 1: Display letters
execute(1) :-
    letters(L),
    write('Current letters: '),
    write(L), nl,
    menu.

% Option 2: Add a letter
execute(2) :-
    write('Enter a letter: '),
    read(Letter),
    letters(L),
    append(L, [Letter], NewList),
    retract(letters(L)),
    assertz(letters(NewList)),
    write('Letter added successfully.'), nl,
    menu.

% Option 3: Add a letter at the top
execute(3) :-
    write('Enter a letter: '),
    read(Letter),
    letters(L),
    NewList = [Letter|L],
    retract(letters(L)),
    assertz(letters(NewList)),
    write('Letter added at the top.'), nl,
    menu.

% Option 4: Add a letter at the bottom
execute(4) :-
    write('Enter a letter: '),
    read(Letter),
    letters(L),
    append(L, [Letter], NewList),
    retract(letters(L)),
    assertz(letters(NewList)),
    write('Letter added at the bottom.'), nl,
    menu.

% Option 5: Delete a letter
execute(5) :-
    write('Enter the letter to delete: '),
    read(Letter),
    letters(L),
    (   select(Letter, L, NewList)
    ->  retract(letters(L)),
        assertz(letters(NewList)),
        write('Letter deleted successfully.'), nl
    ;   write('Letter not found.'), nl
    ),
    menu.

% Option 6: Delete all letters
execute(6) :-
    retract(letters(_)),
    assertz(letters([])),
    write('All letters have been deleted.'), nl,
    menu.

% Option 7: Exit
execute(7) :-
    write('Thank you for playing the Name Game!'), nl.

% Invalid choice
execute(_) :-
    write('Invalid choice. Please try again.'), nl,
    menu.
