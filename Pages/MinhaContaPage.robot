*** Settings ***
Resource        ../Utils/OpenBrowser.robot
Variables       ../Locators/MinhaContaLocators.yml

*** Keywords ***
Aguardar exibir o titulo da pagina Minha Conta
    #Wait para aguardar exibir o titulo da pagina Minha Conta
    Wait Until Element Is Visible    ${MINHACONTA_PAGETITLE_MINHACONTA}