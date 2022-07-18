/*  Trabalho 4 de Paradigmas de Programação
    Eric Fernandes Evaristo
    Problema 32: Salão de Beleza (https://rachacuca.com.br/logica/problemas/salao-de-beleza/)
*/

:- use_module(library(clpfd)).

% Fatos -----------------------------------------------------------------------
% Definições das cores das bolsas
bolsa(amarelo).
bolsa(azul).
bolsa(branco).
bolsa(verde).
bolsa(vermelho).

% Definições dos gentílicos
gentilico(gaucha).
gentilico(baiana).
gentilico(fluminense).
gentilico(mineira).
gentilico(paulista).

% Definições dos sucos
suco(abacaxi).
suco(laranja).
suco(limao).
suco(maracuja).
suco(morango).

% Definições dos sucos
nome(ana).
nome(claudia).
nome(mariana).
nome(tina).
nome(vivian).

% Definições das profissões
profissao(avogada).
profissao(cozinheira).
profissao(dentista).
profissao(publicitaria).
profissao(tradutora).

% Definições do que está sendo feito
fazer(alisar).
fazer(cortar).
fazer(maquiagem).
fazer(manicure).
fazer(tingir).

% Posicionamento --------------------------------------------------------------

left(Problem, C1, C2, Immediate) :-
    nth0(I1, Problem, C1),
    nth0(I2, Problem, C1),
    Ic is I2 - 1,
    (   Immediate == true
    ->  I1 == Ic
    ;   I1 =< Ic
    ).

right(Problem, C1, C2, Immediate) :-
    nth0(I1, Problem, C1),
    nth0(I2, Problem, C1),
    Ic is I2 + 1,
    (   Immediate == true
    ->  I1 == Ic
    ;   I1 >= Ic
    ).

position(Problem, C, It) :-
    nth0(I, Problem, C),
    I == It.

first_or_last(Problem, C) :-
    length(Problem, Size),
    LastIndex is Size - 1,
    position(Problem, C, 0);
    position(Problem, C, LastIndex).

next(Problem, C1, C2) :-
    nextto(C1, C2, Problem);
    nextto(C2, C1, Problem).

client_between(Problem, C1, C2, C3) :-
    left(Problem, C1, C2, false),
    right(Problem, C3, C2, false).

% Resolução -------------------------------------------------------------------

main(Problem) :-

    Problem = [client(B1, G1, S1, N1, P1, F1),
               client(B2, G2, S2, N2, P2, F2),
               client(B3, G3, S3, N3, P3, F3),
               client(B4, G4, S4, N4, P4, F4),
               client(B5, G5, S5, N5, P5, F5)],

    % A mulher que vai Tingir os cabelos está exatamente à esquerda da Cláudia
    left(Problem, client(_, _, _, _, _, tingir), client(_, _, _, claudia, _, _), true),

    % A moça que está no meio vai Alisar os cabelos
    position(Problem, client(_, _, _, _, _, alisar), 2),

    % Quem vai Cortar os cabelos está em algum lugar entre a Fluminense e a que tem a bolsa Vermelha, que está à
    % direita
    client_between(Problem,
                   client(_, fluminense, _, _, _, _),
                   client(_, _, _, _, _, cortar),
                   client(vermelho, _, _, _, _, _)),

    % Quem vai fazer Maquiagem está na primeira cadeira
    position(Problem, client(_, _, _, _, _, maquiagem), 0),

    % A Paulista está sentada exatamente à esquerda da Publicitária

    halt.
