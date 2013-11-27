:- load_files([wumpus1]).

:-dynamic([sair/1,atira/1,viradas/1,gold/1,pegar/1]).

init_agent :- 
    writeln('Agente iniciando...'), 
	retractall(sair(_)),
	retractall(atira(_)),
	retractall(viradas(_)),
	retractall(gold(_)),
	retractall(pegar(_)),
	assert(sair([climb])),
	assert(atira([shoot,goforward,goforward,goforward])),
	assert(viradas(0)),
	assert(gold(0)),
	assert(pegar([grab,turnleft,turnleft])).

restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).
	
agente003([_,_,yes,_,_],grab):- %pega o ouro%
	somarouro(0).

agente003([_,_,_,_,_],turnleft):-
	gold(1),
	somarouro(1).

agente003([_,_,_,_,_],turnleft):-
    gold(2),
    somarouro(2).

agente003([_,yes,_,_,_],P):- %se houver brisa na casa (1,1) ele sai
    sair([P|T]),
    retractall(sair(_)),
    assert(sair(T)).
%   assert(sair([turnleft,goforward])).

agente003([_,_,_,yes,_],turnleft):- %quando bate a 1 vez vira a esquerda%
	gold(0),
	viradas(0),
	somarviradas(0).   

agente003([_,_,_,yes,_],turnleft):- %quando bate a 2 vez vira a esquerda%
    gold(0),
	viradas(1),
    somarviradas(1).
	

agente003([_,_,_,yes,_],turnleft):- %quando bate a 3 vez vira a esquerda%
    gold(0),
	viradas(2),
    somarviradas(2).

agente003([_,_,_,yes,_],climb):- %quando bate a 4 vez sai do mapa%
    gold(0),
	viradas(3).

agente003([_,_,_,yes,_],turnright):- %quando bate a 3 vez vira a esquerda%
    gold(3),
    viradas(3),
    diminuirviradas(3).

agente003([_,_,_,yes,_],turnright):- %quando bate a 3 vez vira a esquerda%
    gold(3),
    viradas(2),
    diminuirviradas(2).

agente003([_,_,_,yes,_],turnright):- %quando bate a 3 vez vira a esquerda%
    gold(3),
    viradas(1),
    diminuirviradas(1).

agente003([_,_,_,yes,_],climb):- %quando bate a 3 vez vira a esquerda%
    gold(3),
    viradas(0).






agente003([yes,_,_,_,no],P):- %quando sentir fedor atira%
	atira([P|T]),
	retractall(atira(_)),
	assert(atira(T)).

agente003([_,_,no,_,no],goforward). %anda para frente%

somarviradas(X):-                      %funcao para somar o numero de viradas%
    retractall(viradas(_)),
    Y is X+1,
    assert(viradas(Y)).

somarouro(X):-                      %funcao para somar o numero de ouro%
    retractall(gold(_)),
    Y is X+1,
    assert(gold(Y)).

diminuirviradas(X):-                      %funcao para somar o numero de viradas%
    retractall(viradas(_)),
    Y is X-1,
    assert(viradas(Y)).


direita(turnright).
esquerda(turnleft).
climb(climb).

%Fedor,Vento,Brilho,Trombada,Grito]
% Acoes possiveis:
% goforward - andar
% turnright - girar sentido horario
% turnleft - girar sentido anti-horario
% grab - pegar o ouro
% climb - sair da caverna
% shoot - atirar a flecha
                                                           
