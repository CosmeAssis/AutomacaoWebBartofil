*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Resource    ../Utils/GerarDadosFake.robot
Variables    ../Data/NovaEmpresaInputText.yml
Variables    ../Locators/NovaEmpresa_Locators.yml

*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
    Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${NOVAEMPRESA_CNPJ_VALIDO}
    Wait Until Element Is Visible    ${NOVAEMPRESA_INPUT_COMPANYNAME}    5s
    Gerar Dados Fake Cadastro com Sucesso

E clicar em Aceito receber informações de acordo com a Politica de Segurança
    Click Element    ${NOVAEMPRESA_CHECKBOX_LGPD}       

E clicar em Criar Conta
    Click Element    ${NOVAEMPRESA_BUTTON_CRIARCONTA}
    Sleep    180s