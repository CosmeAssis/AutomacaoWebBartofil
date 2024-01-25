*** Settings ***
Resource    ../Resource/Utils/OpenBrowser.robot
Resource    ../Resource/Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup       Abrir o navegador
##Execução após execução do teste
Test Teardown    Fechar o navegador

*** Test Cases ***

CN0001-Venda de Produto nao configuravel com metodo de pagamento Boleto Antecipado
    Dado que acesso o site do parceiro Bartofil
    E realizo o login com sucesso
    Quando pesquisar o produto com SKU
    E adicionar o produto no carrinho
    E selecionar o metodo de pagamento como Boleto Antecipado
    E verificar o desconto de 3 porcento
    E clicar em Vender
    Entao mensagem de venda realizada com sucesso é exibida
