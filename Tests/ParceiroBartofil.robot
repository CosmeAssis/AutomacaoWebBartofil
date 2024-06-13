*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Resource    ../Pages/HomePage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador

*** Test Cases ***
CN01-Realizar cadastro com sucesso no programa do Parceiro Bartofil
    [Tags]    loginsucesso
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha   ${CNPJ_PARCEIRO}    ${PASSWORD_PARCEIRO}