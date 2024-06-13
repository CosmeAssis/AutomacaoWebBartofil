*** Settings ***
Resource            ../Utils/OpenBrowser.robot
Resource            ../Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador


*** Test Cases ***
Cenário 1: Realizar login com sucesso no site do parceiro Bartofil
    [Tags]    loginsucesso
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha    ${CNPJ_EMPRESA_APROVADA}    ${PASSWORD_VALIDO}
    E clicar em Entrar
    Então o Minha Conta será exibido no header

Cenário 2: Realizar login com conta em aprovação
    [Tags]    loginemaprovacao
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha    ${CNPJ_EMPRESA_EM_APROVACAO}    ${PASSWORD_VALIDO}
    E clicar em Entrar
    Então mensagem que a conta ainda não foi aprovada é exibida

Cenário 3: Realizar login com senha incorreta
    [Tags]    loginsenhaincorreta
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha    ${CNPJ_EMPRESA_APROVADA}    ${PASSWORD_INVALIDO}
    E clicar em Entrar
    Então mensagem informando que Login e Senha é inválido é exibida
