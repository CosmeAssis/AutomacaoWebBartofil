*** Settings ***
Resource    ../Resource/Utils/OpenBrowser.robot
Resource    ../Resource/Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup       Abrir o navegador
##Execução após execução do teste
Test Teardown    Fechar o navegador

*** Test Cases ***

Cenário 1: Realizar login com sucesso no site do parceiro Bartofil
    [Tags]    LoginSucesso
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra: se 
    E preencher login e senha
    E clicar em Entrar
    Então o Minha Conta será exibido no header

Cenário 2: Realizar login com conta em aprovação
    [Tags]    LoginEmAprovacao
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra: se 
    E preencher login e senha de uma conta em aprovação
    E clicar em Entrar
    Então mensagem que a conta ainda não foi aprovada é exibida

Cenário 3: Realizar login com senha incorreta
    [Tags]    LoginSenhaIncorreta
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra: se
    E preencher com uma senha incorreta
    E clicar em Entrar
    Então mensagem informando que Login e Senha é inválido é exibida