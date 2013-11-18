:- load_files([wumpus1]).

init_agent :- 
    writeln('Agente iniciando...'). 


restart_agent :-
    init_agent.


run_agent(Pe,Ac):-
    agente003(Pe,Ac).



	
agente003([_,_,yes,_,_],grab).
agente003([_,_,_,yes,_],turnleft).

agente003([_,_,no,_,_],goforward).
%agente003([no,no,_,_,_],goforward).%


                                                           
