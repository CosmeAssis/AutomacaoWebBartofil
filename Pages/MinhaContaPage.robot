*** Settings ***
Resource        ../Utils/OpenBrowser.robot
Variables       ../Locators/MinhaContaLocators.yml


*** Keywords ***
Aguardar exibir o titulo da pagina Minha Conta
    # Wait para aguardar exibir o titulo da pagina Minha Conta
    Wait Until Element Is Visible    ${MINHACONTA_PAGETITLE_MINHACONTA}

E o usuário clica em "Quero me cadastrar" em Parceiro Bartofil
    Scroll Element Into View    ${MINHACONTA_LABEL_QUEROMECADASTRAR}
    Click Element    ${MINHACONTA_LABEL_QUEROMECADASTRAR}
    Wait Until Element Is Visible    ${MINHACONTA_TITLE_FORMULARIOCADPARCEIRO}