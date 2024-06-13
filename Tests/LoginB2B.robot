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
    Quando o usuario realizar o login com o CNPJ e senha    ${CNPJ_EMPRESA_APROVADA}    ${PASSWORD_VALIDO}
    Então o Minha Conta será exibido no header

Cenário 2: Realizar login com conta em aprovação
    [Tags]    loginemaprovacao
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha    ${CNPJ_EMPRESA_EM_APROVACAO}    ${PASSWORD_VALIDO}
    Então mensagem que a conta ainda não foi aprovada é exibida

Cenário 3: Realizar login com senha incorreta
    [Tags]    loginsenhaincorreta
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha    ${CNPJ_EMPRESA_APROVADA}    ${PASSWORD_INVALIDO}
    Então mensagem informando que Login e Senha é inválido é exibida
