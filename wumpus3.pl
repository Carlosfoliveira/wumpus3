:- load_files([wumpus1]).

:-dynamic([sair/1,atira/1,viradas/1,gold/1,pegar/1,casa/1,viraatira/1]).

init_agent :- 
    writeln('Agente iniciando...'), 
	retractall(sair(_)),%limpando todas as variaveis dinamicas
	retractall(atira(_)),
	retractall(viradas(_)),
	retractall(gold(_)),
	retractall(pegar(_)),
	retractall(viraatira(_)),
	retractall(casa(_)),
	assert(sair([climb])), %Quando sentir a 1 brisa vai dar climb, servindo para quando sentir brisa na casa (1,1) nao arriscar e sair logo
	assert(atira([shoot,goforward,goforward,goforward])), %Quando sentir o Fedor sem ser na quinas do mapa vai atirar e andar ate sair do Fedor
	assert(viradas(0)), %Conta o numero de vezes o Agente virou para sair quando bater a 4 vez ou para dar Backtracking
	assert(gold(0)), %Saber se ja pegou o ouro para comecar o Backtracking
	assert(pegar([grab,turnleft,turnleft])), %Quando pegar o ouro dar uma volta de 180 graus
	assert(viraatira([turnleft,shoot,goforward,goforward,goforward])), %Quando estiver na quina do mapa e sentir uma brisa ele vira antes de atirar
	assert(casa(0)). %Contar em que casa esta para saber se esta na quina ou nao

restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).
	
agente003([_,_,yes,_,_],grab):- %pega o ouro e soma 1 ao ouro
	somarouro(0).

agente003([_,_,_,_,_],turnleft):- %Começando a dar o giro de 180 graus depois de pegar o ouro
	gold(1),
	somarouro(1).

agente003([_,_,_,_,_],turnleft):- %Termino de giro de 180 grays depois de pegar o ouro
    gold(2),
    somarouro(2).


agente003([_,yes,_,_,_],P):- %se houver brisa na casa (1,1) ele da climb
	casa(0),
    sair([P|T]), %pegando apenas a cabeça da variavel dinamica
    retractall(sair(_)),
    assert(sair(T)). %adicionando a variavel dinamica menos a cabeça

agente003([_,_,_,yes,_],turnleft):- %quando bate a 1 vez sem ouro vira a esquerda e zera as casas
	gold(0),
	viradas(0),
	somarviradas(0),
	zerarcasa(3).   

agente003([_,_,_,yes,_],turnleft):- %quando bate a 2 vez sem ouro vira a esquerda e zera as casas
    gold(0),
	viradas(1),
    somarviradas(1),
	zerarcasa(3).
	

agente003([_,_,_,yes,_],turnleft):- %quando bate a 3 vez sem ouro vira a esquerda e zera as casas
    gold(0),
	viradas(2),
    somarviradas(2),
	zerarcasa(3).

agente003([_,_,_,yes,_],climb):- %quando bate a 4 vez sem ouro sai do mapa
    gold(0),
	viradas(3).

agente003([_,_,_,yes,_],turnright):- %Começo do Backtracking, vai diminuindo as viradas ao longo que bate e virando a direita
    gold(3),
    viradas(3),
    diminuirviradas(3).

agente003([_,_,_,yes,_],turnright):- %quando virada 2 com ouro vira a direita
    gold(3),
    viradas(2),
    diminuirviradas(2).

agente003([_,_,_,yes,_],turnright):- %quando virada 1 com ouro vira a direita
    gold(3),
    viradas(1),
    diminuirviradas(1).

agente003([_,_,_,yes,_],climb):- %quando virada chega a 0 com o ouro ele da climb para sair
	gold(3),
    viradas(0).



agente003([yes,_,_,_,no],P):- %quando sentir fedor na casa 0 atira para frente e continua andando
	casa(0),
	atira([P|T]),
	retractall(atira(_)),
	assert(atira(T)),
	retractall(viraatira(_)).

agente003([yes,_,_,_,no],P):- %quando sentir fedor na casa 1 atira para frente e continua andando
	casa(1),
    atira([P|T]),
    retractall(atira(_)),
    assert(atira(T)),
	retractall(viraatira(_)).

agente003([yes,_,_,_,no],P):- %quando sentir fedor na casa 2 atira para frente e continua andando
	casa(2),
    atira([P|T]),
    retractall(atira(_)),
    assert(atira(T)),
	retractall(viraatira(_)).

agente003([yes,_,_,_,no],turnleft):- %quando sentir fedor na casa 3, ou seja, em uma quina ele vira para esquerda e depois atira
	casa(3),
	viradas(X),
	somarviradas(X),
	zerarcasa(3).

agente003([_,_,no,_,no],goforward):- %anda para frente quando n sente brilho ou grito e vai somando 1 a casa toda vez q andar
	casa(X),
	somarcasa(X).

somarviradas(X):-  %funcao para somar o numero de viradas
    retractall(viradas(_)),
    Y is X+1,
    assert(viradas(Y)).

somarouro(X):-  %funcao para somar o numero de ouro
    retractall(gold(_)),
    Y is X+1,
    assert(gold(Y)).

diminuirviradas(X):-  %funcao para diminuir o numero de viradas
    retractall(viradas(_)),
    Y is X-1,
    assert(viradas(Y)).

somarcasa(X):- %funcao para somar o numero da casa
	retractall(casa(_)),
	Y is X+1,
	assert(casa(Y)).

zerarcasa(X):- %funcao para zerar o numero da casa
	retractall(casa(_)),
	Y is X-3,
	assert(casa(Y)).

                        
