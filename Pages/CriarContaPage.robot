*** Settings ***
Resource        ../Utils/Resource.robot
Resource        ../Utils/OpenBrowser.robot
Variables       ../Locators/CriarContaLocators.yml


*** Keywords ***
Verificar que está selecionado a opcao Pessoa Juridica
    # Aguardar exibir na tela a opcao de cliente Pessoa Juridica
    Wait Until Element Is Visible    ${CRIARCONTA_INPUT_PESSOAJURIDICA}

Clicar em Proxima Etapa
    # Clicar no botao Proaxima Etapa
    Click Element    ${CRIARCONTA_BUTTON_PROXIMAETAPA}
