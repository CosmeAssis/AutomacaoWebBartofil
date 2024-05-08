*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables    ../Locators/CriarConta_Locators.yml

*** Keywords ***
E verificar que está selecionado a opcao Pessoa Juridica
    Wait Until Element Is Visible    ${CRIARCONTA_INPUT_PESSOAJURIDICA}

E clicar em Proxima Etapa
    Click Element    ${CRIARCONTA_BUTTON_PROXIMAETAPA}