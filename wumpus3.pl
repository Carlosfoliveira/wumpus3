:- load_files([wumpus1]).

:-dynamic([sair/1,atira/1,viradas/1]).

init_agent :- 
    writeln('Agente iniciando...'), 
	retractall(sair(_)),
	retractall(atira(_)),
	retractall(viradas(_)),
	assert(sair([climb])),
	assert(atira([shoot,goforward,goforward,goforward])),
	assert(viradas(0)).

restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).
	
agente003([_,_,yes,_,_],grab). %pega o ouro%

agente003([_,yes,_,_,_],P):- %se houver brisa na casa (1,1) ele sai
    sair([P|T]),
    retractall(sair(_)),
    assert(sair(T)).
%   assert(sair([turnleft,goforward])).

agente003([_,_,_,yes,_],turnleft):- %quando bate a 1 vez vira a esquerda%
	viradas(0),
	somar(0).

agente003([_,_,_,yes,_],turnleft):- %quando bate a 2 vez vira a esquerda%
    viradas(1),
    somar(1).

agente003([_,_,_,yes,_],turnleft):- %quando bate a 3 vez vira a esquerda%
    viradas(2),
    somar(2).

agente003([_,_,_,yes,_],climb):- %quando bate a 4 vez sai do mapa%
    viradas(3).

somar(X):-						%função para somar o numero de viradas%	
	retractall(viradas(_)), 
	Y is X+1,
	assert(viradas(Y)).	

agente003([yes,_,_,_,no],P):- %quando sentir fedor atira%
	atira([P|T]),
	retractall(atira(_)),
	assert(atira(T)).

agente003([_,_,no,_,no],goforward). %anda para frente%

%Fedor,Vento,Brilho,Trombada,Grito]
% Acoes possiveis:
% goforward - andar
% turnright - girar sentido horario
% turnleft - girar sentido anti-horario
% grab - pegar o ouro
% climb - sair da caverna
% shoot - atirar a flecha
                                                           
