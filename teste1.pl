:- load_files([wumpus1]).

init_agent :- % se nao tiver nada para fazer aqui, simplesmente termine com um ponto (.)
    writeln('Agente iniciando...'). % apague esse writeln e coloque aqui as acoes para iniciar o agente

% esta funcao permanece a mesma. Nao altere.
restart_agent :-
    init_agent.

% esta e a funcao chamada pelo simulador. Nao altere a "cabeca" da funcao. Apenas o corpo.
% Funcao recebe Percepcao, uma lista conforme descrito acima.
% Deve retornar uma Acao, dentre as acoes validas descritas acima.

run_agent(Pe,Ac):-
    agente003(Pe,Ac).

agente003([_,_,yes,_,_],grab).
agente003([_,_,_,yes,_],turnleft).


agente003([_,_,_,no,_],goforward).



                                                           
