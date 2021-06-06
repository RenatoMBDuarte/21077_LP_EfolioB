:- [dados].
:- [funcoes].

:- dynamic inventario/2.

main :-																						%%'Apresenta o manu ao utilizador'
	writeln("Menu"), nl, 
    writeln('>> Escolha um comando, seguido de um ponto final:'),
    writeln('  0. Sair'),
    writeln('  1. Listar clientes'),
	writeln('  2. Listar clientes com credito aaa'),
	writeln('  3. Totalizar clientes por cidade'),
	writeln('  4. Lista de vendas'),
	writeln('  5. Stock do artigo'),
	writeln('  6. Verifica Quantidades de Stock minimo'),
	writeln('  7. Validar venda'),
	writeln('  8. Retifica inventario'),
	writeln('  9. Venda de artigo'),
	writeln(' 10. Inventario dos artigos'),
    read(Comando),
    escolha(Comando).
	

retornamenu :-
	nl, writeln("c. para continuar"),
    read(_),																				%%'Aceita qualquer valor, dá a ideia de passagem de menu ao utilizador'
    main. 																					%%'Volta a chamar o menu'
	
escolha(0)  :- writeln('Sair'), halt.

escolha(1)  :- nl, writeln('Lista de clientes:'),
				   listar_cliente, retornamenu.												%%'Respectiva função e retorno ao menu'

escolha(2)  :- nl, writeln('Cliente(s) com nivel de credito aaa:'),
				   listar_cliente_bom, retornamenu.											%%'Respectiva função e retorno ao menu'

escolha(3)  :- nl, writeln('Totalizar clientes por cidade:'),
				   writeln('Qual a cidade?'),read(Cidade),									%%'Variavel para a função'	
				   total_cliente_cidade(Cidade),retornamenu.								%%'Respectiva função e retorno ao menu'

escolha(4)  :- nl, writeln('Lista de vendas'),
				   listar_cliente_vendas, retornamenu.										%%'Respectiva função e retorno ao menu'

escolha(5)  :- nl, writeln('Stock do artigo:'),
				   writeln('Qual o codigo?'),read(Codigo),									%%'Variavel para a função'	
				   inventario_quantidade_stock(Codigo),retornamenu.							%%'Respectiva função e retorno ao menu'

escolha(6)  :- nl, writeln('Verifica Quantidades de Stock minimo'),
			       artigo_verificar_abaixo_min_alerta, retornamenu. 						%%'Respectiva função e retorno ao menu'

escolha(7)  :- nl, writeln('Qual o cliente?'),read(Cliente),								%%'Variavel para a função'	
				   writeln('Qual o artigo?'),read(Artigo),									%%'Variavel para a função'	
				   writeln('Quantidade de venda?'),read(Qtd),								%%'Variavel para a função'	
				   venda_validar_artigo_cliente(Cliente,Artigo,Qtd), retornamenu.			%%'Respectiva função e retorno ao menu'

escolha(8)	:- nl, writeln('Qual o artigo?'),read(Artigo),
				   writeln('Qual a nova quantidade de stock?'),read(Qtd),					%%'Variavel para a função'	
 				   inventario_atualiza_artigo(Artigo,Qtd), retornamenu.						%%'Respectiva função e retorno ao menu'

escolha(9)  :- nl, writeln('Qual o cliente?'),read(Cliente),								%%'Variavel para a função'	
				   writeln('Qual o artigo?'),read(Artigo),									%%'Variavel para a função'	
				   writeln('Quantidade de venda?'),read(Qtd),								%%'Variavel para a função'		
				   venda_artigo_cliente(Cliente,Artigo,Qtd), retornamenu.					%%'Respectiva função e retorno ao menu'
				  
escolha(10) :- nl, writeln('Inventario'),
				  inventario_relatorio, retornamenu.										%%'Respectiva função e retorno ao menu'


