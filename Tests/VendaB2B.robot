*** Settings ***
Documentation       TESTE AUTOMATIZADO PARA VALIDAR O FLUXO DE VENDA NO PORTAL DA BARTOFIL B2B

Resource            ../Utils/OpenBrowser.robot
Resource            ../Pages/HomePage.robot
Resource            ../Pages/PdpPage.robot
Resource            ../Pages/CheckoutPage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador


*** Test Cases ***
Cenário 1: Venda com metodo de pagamento Boleto Antecipado sem usar pontos Parceiro Bartofil
    [Documentation]    Realizada a venda de um produto nao configuravel com metodo de pagamento.
    ...    Esta sendo validado o desconto de 3% com sucesso e a conclusao do pedido para pagamento.
    [Tags]    boletoantecipado_sem_pontos_parceiro
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha
    ...    ${CNPJ_VENDA_PONTOS_PARCEIRO}
    ...    ${PASSWORD_CNPJ_PONTOS_PARCEIRO}
    E pesquisar o produto com SKU 108384
    E validar tela de PDP
    E adicionar o produto no carrinho
    E clicar para nao utilizar o programa de ponto do parceiro
    E selecionar o metodo de pagamento como Boleto Antecipado
    E verificar o desconto de 3% do Boleto Antecipado
    E clicar em Finalizar Compra com Boleto Antecipado
    Entao mensagem Pronto! Já recebemos o seu pedido. é exibida

Cenário 2: Venda com metodo de pagamento Cartao de Credito sem usar pontos Parceiro Bartofil
    [Documentation]    Realizada a venda de um produto nao configuravel com metodo de pagamento Cartao de Credito.
    [Tags]    vendacartaocredito_sem_pontos_parceiro
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha
    ...    ${CNPJ_VENDA_PONTOS_PARCEIRO}
    ...    ${PASSWORD_CNPJ_PONTOS_PARCEIRO}
    E pesquisar o produto com SKU 9046
    E validar tela de PDP
    E adicionar o produto no carrinho
    E clicar para nao utilizar o programa de ponto do parceiro
    E selecionar o metodo de pagamento como Cartao de Credito
    E digitar as informacoes do cartao
    E clicar em Finalizar Compra
    Entao mensagem Pronto! Já recebemos o seu pedido. é exibida

Cenário 3: Venda com metodo de pagamento Pix sem usar pontos Parceiro Bartofil
    [Documentation]    Realizada a venda de um produto nao configuravel com metodo de pagamento Pix, onde o teste foi encerrado na validacao do desconto de 3%.
    ...    Porque esta retornando erro no servidor da getnet devido a falta da instituicao finaceira nao esta configurada
    [Tags]    pedidometodopix_sem_pontos_parceiro
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha    
    ...    ${CNPJ_VENDA_PONTOS_PARCEIRO}
    ...    ${PASSWORD_CNPJ_PONTOS_PARCEIRO}
    E pesquisar o produto com SKU 124418
    E validar tela de PDP
    E adicionar o produto no carrinho
    E clicar para nao utilizar o programa de ponto do parceiro
    E selecionar o metodo de pagamento como Pix
    Entao o desconto de 3% do Pix é verificado

Cenário 4: Pedido com metodo de pagamento Boleto a Prazo sem usar pontos do Parceiro Bartofil
    [Tags]    boletoaprazo_sem_pontos_parceiro
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha
    ...    ${CNPJ_VENDA_BOLETOAPRAZO}
    ...    ${PASSWORD_CNPJ_PONTOS_PARCEIRO}
    E pesquisar o produto com SKU 124418
    E validar tela de PDP
    E adicionar o produto no carrinho
    E clicar para nao utilizar o programa de ponto do parceiro
    E selecionar o metodo de pagamento como Boleto a Prazo
    E clicar em Finalizar Compra com Boleto a Prazo
    Entao mensagem Pronto! Já recebemos o seu pedido. é exibida