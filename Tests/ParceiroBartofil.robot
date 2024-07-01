*** Settings ***
Resource            ../Utils/OpenBrowser.robot
Resource            ../Pages/HomePage.robot
Resource            ../Pages/CadastrarParceiroPage.robot

##Execução antes de iniciar o teste
Test Setup          Abrir o navegador
##Execução após execução do teste
Test Teardown       Fechar o navegador


*** Test Cases ***
Cenário 1: Realizar cadastro com sucesso no programa do Parceiro Bartofil
    [Tags]    cadastro_parceiro_bartofil
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha
    ...    ${CNPJ_PARCEIRO_AUTOMACAO}
    ...    ${PASSWORD_PARCEIRO_AUTOMACAO}
    E o usuário clica em "Minha Conta"
    E o usuário clica em "Quero me cadastrar" em Parceiro Bartofil
    E o usuário preenche os dados do formulário de cadastro do parceiro
    E o usuário clica em "Enviar Solicitação para Análise"
    Então o sistema deve exibir uma mensagem de confirmação de envio

Cenário 2: Realizar tentativa de cadastro no programa do Parceiro Bartofil com email já cadastrado
    [Tags]    cadastrar_parceiro_emailcadastro
    Dado que estou na página inicial do site www.bartofil.com.br
    Quando o usuario realizar o login com o CNPJ e senha
    ...    ${CNPJ_PARCEIRO_AUTOMACAO}
    ...    ${PASSWORD_PARCEIRO_AUTOMACAO}
    E o usuário clica em "Minha Conta"
    E o usuário clica em "Quero me cadastrar" em Parceiro Bartofil
    E o usuário preenche um email já cadastrado no parceiro Bartofil
    E o usuário clica em "Enviar Solicitação para Análise"
    Então o sistema deve exibir uma mensagem de email já cadastrado no Parceiro Bartofil