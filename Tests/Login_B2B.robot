*** Settings ***
Resource    ../Resource/Utils/OpenBrowser.robot
Resource    ../Resource/Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup       Abrir o navegador
##Execução após execução do teste
Test Teardown    Fechar o navegador

*** Test Cases ***

CN0001-Realizar login com sucesso no site do parceiro Bartofil
    [Tags]    login_sucesso
    Dado que acesso o site do parceiro Bartofil
    Quando clicar em Olá! Entre ou cadastra-se 
    E preencher login e senha
    E clicar em Entrar
    Então o Minha Conta será exibido no header

CN0002-Realizar login com conta em aprovação
    [Tags]    login_conta_emaprovacao
    Dado que acesso o site do parceiro Bartofil
    Quando clicar em Olá! Entre ou cadastra-se 
    E preencher login e senha de uma conta em aprovação
    E clicar em Entrar
    Então mensagem que a conta ainda não foi aprovada é exibida

CN0003-Realizar login com senha incorreta
    [Tags]    login_senha_incorreta
    Dado que acesso o site do parceiro Bartofil
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher com uma senha incorreta
    E clicar em Entrar
    Então mensagem informando que Login e Senha é inválido é exibida