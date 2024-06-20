*** Settings ***
Resource        ../Utils/Resource.robot
Resource        ../Utils/GerarDadosFake.robot
Variables       ../Locators/CadastrarParceiroLocators.yml
Variables       ../Data/CadastrarParceiroInputText.yml
Variables       ../Locators/ContratoParceiroLocators.yml


*** Keywords ***
E o usuário preenche os dados do formulário de cadastro do parceiro
    Gerar Celular no Cadastro do Parceiro
    Gerar Nome da Loja do Parceiro
    Input Text    ${MINHACONTA_INPUT_RCA}    ${ID_RCA}
    Click Element    ${MINHACONTA_INPUT_URLPARCEIRO}

E o usuário clica em "Enviar Solicitação para Análise"
    Click Element    ${CADASTRARPARCEIRO_BUTTON_ENVIARPANALISE}

Então o sistema deve exibir uma mensagem de confirmação de envio
    Wait Until Element Is Visible    ${CONTRATO_MESSAGE_ENVIADOPANALISE}    10s
