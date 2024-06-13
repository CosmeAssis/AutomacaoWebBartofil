*** Settings ***
Resource            ../Utils/OpenBrowser.robot
Resource            ../Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador


*** Test Cases ***
Cenário 1: Realizar cadastro com sucesso no programa do Parceiro Bartofil
    [Tags]    loginsucesso
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha    ${CNPJ_PARCEIRO}    ${PASSWORD_PARCEIRO}
    E o usuário clica em "Minha Conta" em Parceiro Bartofil
    E o usuário clica em "Quero me cadastrar"
    E o usuário preenche os dados do formulário de cadastro do parceiro
    E o usuário clica em "Enviar Solicitação para Análise"
    Então o sistema deve exibir uma mensagem de confirmação de envio