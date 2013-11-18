:- load_files([wumpus1]).

:-dynamic([davolta/1]).
davolta([turnleft,turnleft,goforward]).

init_agent :- 
    writeln('Agente iniciando...'), 
	retractall(davolta(_)),
	assert(davolta([turnleft,goforward])).

restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).



	
agente003([_,_,yes,_,_],grab). %pega o ouro%
agente003([_,_,_,yes,_],turnleft). %quando bate vira a esquerda%
%agente003([yes,_,_,_,no],shoot). %quando sentir fedor atira%
agente003([no,no,no,_,_],goforward). %anda para frente sempre%
%agente003([yes,_,_,_,yes],goforward). %qnd matar o wumpus anda para frente
%agente003([no,no,_,_,_],goforward).% quando nao sente brisa ou fedor anda para frente%
agente003([_,yes,_,_,_],P):-
	davolta([P|T]),
	retractall(davolta(_)),
	assert(davolta(T)).








% [Fedor,Vento,Brilho,Trombada,Grito]
% Acoes possiveis:
% goforward - andar
% turnright - girar sentido horario
% turnleft - girar sentido anti-horario
% grab - pegar o ouro
% climb - sair da caverna
% shoot - atirar a flecha
                                                           
