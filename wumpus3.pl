:- load_files([wumpus1]).

init_agent :- 
    writeln('Agente iniciando...'). 


restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).



	
agente003([_,_,yes,_,_],grab). %pega o ouro%
agente003([_,_,_,yes,_],turnleft). %quando bate vira a esquerda%
agente003([yes,_,_,_,_],shoot). %quando sentir fedor atira%
agente003([_,_,no,_,_],goforward). %anda para frente sempre%
%agente003([no,no,_,_,_],goforward). quando n sente brisa ou fedor anda para frente%


                                                           
