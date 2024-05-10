*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Resource    ../Utils/GerarDadosFake.robot
Variables    ../Data/NovaEmpresaInputText.yml
Variables    ../Locators/NovaEmpresa_Locators.yml

*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${NOVAEMPRESA_CNPJ_VALIDO}
    Wait Until Element Is Visible    ${NOVAEMPRESA_INPUT_COMPANYNAME}    5s
    Gerar Dados Fake Cadastro com Sucesso