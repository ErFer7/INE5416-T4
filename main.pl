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
    nth0(I2, Problem, C2),
    Ic is I2 - 1,
    (   Immediate == true
    ->  I1 == Ic
    ;   I1 =< Ic
    ).

right(Problem, C1, C2, Immediate) :-
    nth0(I1, Problem, C1),
    nth0(I2, Problem, C2),
    Ic is I2 + 1,
    (   Immediate == true
    ->  I1 == Ic
    ;   I1 >= Ic
    ).

position(Problem, C, It) :-
    nth0(I, Problem, C),
    I == It.

first_or_last([H|_], C) :-
    C == H;
    last([H|_], C).

next(Problem, C1, C2) :-
    nextto(C1, C2, Problem);
    nextto(C2, C1, Problem).

client_between(Problem, C1, C2, C3) :-
    left(Problem, C1, C2, false),
    right(Problem, C3, C2, false).

% Resolução -------------------------------------------------------------------

main(Problem) :-

    % Lista que representa o problema
    Problem = [client(B1, G1, S1, N1, P1, F1),
               client(B2, G2, S2, N2, P2, F2),
               client(B3, G3, S3, N3, P3, F3),
               client(B4, G4, S4, N4, P4, F4),
               client(B5, G5, S5, N5, P5, F5)],

    % Regras
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
    left(Problem, client(_, paulista, _, _, _, _), client(_, _, _, _, publicitaria, _), true),

    % A Mariana trabalha como Tradutora
    member(client(_, _, _, mariana, tradutora, _), Problem),

    % A Dentista está sentada na quarta cadeira
    position(Problem, client(_, _, _, _, dentista, _), 1),

    % A Cozinheira está sentada ao lado da Mineira
    next(Problem, client(_, _, _, _, cozinheira, _), client(_, mineira, _, _, _, _)),

    % A Ana está exatamente à direita da mulher que veio fazer Maquiagem
    right(Problem, client(_, _, _, ana, _, _), client(_, _, _, _, _, maquiagem), true),

    % Tina está sentada em uma das pontas
    first_or_last(Problem, client(_, _, _, tina, _, _)),

    % A Paulista adora Limonada
    member(client(_, paulista, limao, _, _, _), Problem),

    % A dona da bolsa Vermelha está sentada em algum lugar à esquerda da que bebe suco de Morango
    left(Problem, client(vermelho, _, _, _, _, _), client(_, _, morango, _, _, _), false),

    % Quem bebe suco de Laranja está na segunda cadeira
    position(Problem, client(_, _, laranja, _, _, _), 1),

    % A dona da bolsa Verde está sentada ao lado de quem bebe suco de Maracujá
    next(Problem, client(verde, _, _, _, _, _), client(_, _, maracuja, _, _, _)),

    % A Mineira está sentada exatamente à direita da dona da bolsa Branca
    right(Problem, client(_, mineira, _, _, _, _), client(branco, _, _, _, _, _), true),

    % A Sul-rio-grandense adora suco de Morango
    member(client(_, gaucha, morango, _, _, _), Problem),

    % A Advogada está sentada ao lado da mulher que veio Cortar os cabelos
    next(Problem, client(_, _, _, _, advogada, _), client(_, _, _, _, _, cortar)),

    % A dona da bolsa Amarela está sentada exatamente à esquerda da dona da bolsa Branca
    left(Problem, client(amarelo, _, _, _, _, _), client(branco, _, _, _, _, _), true),

    % Teste de possibilidades

    bolsa(B1),
    bolsa(B2),
    bolsa(B3),
    bolsa(B4),
    bolsa(B5),

    all_distinct([B1, B2, B3, B4, B5]),

    gentilico(G1),
    gentilico(G2),
    gentilico(G3),
    gentilico(G4),
    gentilico(G5),

    all_distinct([G1, G2, G3, G4, G5]),

    suco(S1),
    suco(S2),
    suco(S3),
    suco(S4),
    suco(S5),

    all_distinct([S1, S2, S3, S4, S5]),

    nome(N1),
    nome(N2),
    nome(N3),
    nome(N4),
    nome(N5),

    all_distinct([N1, N2, N3, N4, N5]),

    profissao(P1),
    profissao(P2),
    profissao(P3),
    profissao(P4),
    profissao(P5),

    all_distinct([P1, P2, P3, P4, P5]),

    fazer(F1),
    fazer(F2),
    fazer(F3),
    fazer(F4),
    fazer(F5),

    all_distinct([F1, F2, F3, F4, F5]).
