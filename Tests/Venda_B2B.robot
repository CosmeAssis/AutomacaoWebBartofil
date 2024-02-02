*** Settings ***
Resource    ../Resource/Utils/OpenBrowser.robot
Resource    ../Resource/Pages/HomePage.robot
Resource    ../Resource/Pages/PdpPage.robot
Resource    ../Resource/Pages/CheckoutPage.robot

##Execução antes de iniciar o teste
Test Setup       Abrir o navegador
##Execução após execução do teste
Test Teardown    Fechar o navegador

Documentation    TESTE AUTOMATIZADO PARA VALIDAR O FLUXO DE VENDA NO PORTAL DA BARTOFIL B2B

*** Test Cases ***

CN0001-Venda de Produto nao configuravel com metodo de pagamento Boleto Antecipado
    Dado que acesso o site do parceiro Bartofil
    E realizo o login com sucesso
    Quando pesquisar o produto com SKU 108384
    E validar tela de PDP
    E adicionar o produto no carrinho
    E selecionar o metodo de pagamento como Boleto Antecipado
    E verificar o desconto de 3%
    E clicar em Finalizar Compra
    Entao mensagem Pronto! Já recebemos o seu pedido. é exibida
