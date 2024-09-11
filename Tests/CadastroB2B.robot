*** Settings ***
Documentation       Funcionalidade: Cadastro de cliente Pessoa Jurídica no B2B
...                 Como um novo cliente Pessoa Jurídica
...                 Eu quero me cadastrar no site Bartofil
...                 Para que eu possa acessar e utilizar os serviços oferecidos

Resource            ../Utils/OpenBrowser.robot
Resource            ../Pages/HomePage.robot
Resource            ../Pages/CriarContaPage.robot
Resource            ../Pages/NovaEmpresaPage.robot
Resource            ../Pages/CriarContaPage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador


*** Test Cases ***
Cenário 1: Realizar cadastro de cliente Pessoa Juridica com sucesso no B2B
    [Tags]    cadastropessoafisicasucesso
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando preencher as informacoes do cadastro
    E clicar em Criar Conta
    Entao mensagem Conta criada com sucesso! é exibida
