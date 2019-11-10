/* Save file */
writeData(_,[]) :- !.
writeData(Stream,[X1|Tail]) :-
	write(Stream,X1),
	writeData(Stream,Tail).

writeList(NamaFile, L) :-
	open(NamaFile,write,Stream),
	repeat,
	writeData(Stream,L),
	close(Stream).


/* Read dari file eksternal */
readData(Stream,[]) :-
	at_end_of_stream(Stream), !.

readData(Stream,[X1|Tail]) :-
	get_char(Stream,X1),
	readData(Stream,Tail).

bacaFile(NamaFile,Isi) :-
	open(NamaFile,read,Stream),
	repeat,
	readData(Stream,Isi),
	close(Stream),!.

/* Membaca file menjadi list of lines */
readFileLines(Stream,[]) :-
    at_end_of_stream(Stream).

readFileLines(Stream,[X|L]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,X),
    readFileLines(Stream,L).
