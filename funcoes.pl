
cls :- write('\e[2J').

show_list(X):-
	forall(	member(Y, X), (write(Y), nl) ).											%%'Função para apresentar cada elemento da lista'

listar_cliente :-
	findall(Y,cliente(Y,_,_),Lista),												%%'Utilização do findall, que transformas os resultados numa lista'
	show_list(Lista).																%%'Apresenta dados'
	

listar_cliente_bom :-
	findall(Y,cliente(Y,_,aaa),Lista),												%%'Utilização do findall, que transformas os resultados numa lista'
	show_list(Lista).																%%'Apresenta dados'

total_cliente_cidade(Cidade) :-
	aggregate_all(count, cliente(_,Cidade,_), Count),								%%'Utilização do aggregate_all com a opção count, para contar os clientes por cidade'
	format('A cidade ~w tem um total de ~w cliente(s).', [Cidade, Count]).			%%'Apresenta dados'

listar_cliente_vendas :- 
	findall(
		(Nome, Cidade),
		(cliente(Nome,Cidade,_),vendas(Nome,_,_)),
		Lista),
	write('Cliente(s) com vendas | Cidade : '),nl,									%%'Apresenta cabeçalho ao utilizador'
	show_list(Lista).																%%'Apresenta dados'


inventario_quantidade_stock(Artigo) :-
	findall(																		%%'Utilização do findall, que transformas os resultados numa lista'
		(Artigo, Nome, Inventario),													%%'Dados a colocar na lista'
		(artigo(Artigo,Nome,_),inventario(Artigo,Inventario)),						%%'Condição de procura'
		Lista),																		%%'Lista com o resultado'
	write('Artigo(s) | Nome | Stock'),nl,											%%'Apresenta cabeçalho ao utilizador'
	show_list(Lista).																%%'Apresenta dados'

artigo_verificar_abaixo_min_alerta :-
		write('Referencia | Quantidade | Limite | Estado'),nl,						%%'Apresenta cabeçalho ao utilizador'
	   findall(																		%%'Utilização do findall, que transformas os resultados numa lista'
			(Ref,Qtd,Limite,' Alerta! Abaixo stock minimo'),						%%'Dados a colocar na lista'
			(artigo(Ref,_,Qtd),inventario(Ref,Limite), Qtd < Limite),				%%'Condição de procura'
			Lista																	%%'Devolve para a lista'
		),
		show_list(Lista),															%%'Apresenta dados quando a quantidade é inferior ao limite'
	   findall(																		%%'Utilização do findall, que transformas os resultados numa lista'
			(Ref,Qtd,Limite,' Dentro do limite'),									%%'Dados a colocar na lista'
			(artigo(Ref,_,Qtd),inventario(Ref,Limite), Qtd >= Limite),				%%'Condição de procura'
			Lista2																	%%'Devolve para a lista'		
		),
		show_list(Lista2).															%%'Apresenta dados quando a quantidade é superior ao limite'

venda_validar_artigo_cliente(Cliente,Artigo,Qtd) :-
		cliente(Cliente,_,aaa),														%%'Condições'
		inventario(Artigo,Stock),													%%'Condições'
		Qtd =< Stock																%%'Condições'
			-> write('Pode efetuar a venda.'),nl;		 							%%'Se Sim'
			write('Venda nao pode ser efetuada!'),nl.								%%'Se Não'

inventario_atualiza_artigo(Artigo,Qtd) :-
		retract(inventario(Artigo,_)),												%%'Remove a linha do sotck do artigo'
		assert(inventario(Artigo,Qtd)),												%%'Atualiza o novo Stock'	
		format('Artigo ~w atualizado com o novo stock de ~w.',[Artigo,Qtd]),nl.		%%'Apresenta mensagem ao utilizador'

venda_artigo_cliente(Cliente,Artigo,Qtd):-
		venda_validar_artigo_cliente(Cliente,Artigo,Qtd)							%%'Condições'
			->  inventario(Artigo,StockAtual),										%%'Se Sim, primeiro guarda o StockAtual'
				retract(inventario(Artigo,_)),										%%'Remove a linha do sotck do artigo'
				Result is StockAtual-Qtd, 											%%'Calcula o novo Stock'						 
				assert(inventario(Artigo,Result)),									%%'Atualiza o novo Stock'	
			write('Venda eftuada.'),nl;			 	 
			write('Venda nao pode ser efetuada!'),nl.								%%'Se não, apresenta menssagem'
	

inventario_relatorio :-	
	findall(																		%%'Utilização do findall, que transformas os resultados numa lista'
		(Artigo, Nome, Inventario),													%%'Dados a colocar na lista'
		(artigo(Artigo,Nome,_),inventario(Artigo,Inventario)), 						%%'Condição de procura'
		Lista),																		%%'Devolve para a lista'
	write('Artigo(s) | Nome | Stock'),nl,											%%'Apresenta cabeçalho ao utilizador'
	show_list(Lista).																%%'Apresenta dados'
	
	
	
	 