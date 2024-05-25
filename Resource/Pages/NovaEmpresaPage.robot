*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Resource    ../Utils/GerarDadosFake.robot
Variables    ../Data/NovaEmpresaInputText.yml
Variables    ../Locators/NovaEmpresaLocators.yml

*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    Gerar Dados Fake Cadastro com Sucesso
    Wait Until Element Is Visible    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}    5s

E clicar em Aceito receber informações de acordo com a Politica de Segurança
    Click Element    ${NOVAEMPRESA_CHECKBOX_LGPD}       

E clicar em Criar Conta
    Click Element    ${NOVAEMPRESA_BUTTON_CRIARCONTA}

Entao mensagem ${NOVAEMPRESA_MENSAGEM_CONTACRIADA_SUCESSO} é exibida
    Sleep    3
    # Aguardar exibir do pedido realizado com sucesso
    Wait Until Page Contains    ${NOVAEMPRESA_MENSAGEM_CONTACRIADA_SUCESSO}