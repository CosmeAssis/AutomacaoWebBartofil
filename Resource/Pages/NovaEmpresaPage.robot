*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Resource    ../Utils/GerarDadosFake.robot
Variables    ../Data/NovaEmpresaInputText.yml
Variables    ../Locators/NovaEmpresaLocators.yml

*** Variables ***
${URL_ESPERADA_CADASTRO_SUCESSO}    https://mcstaging.bartofil.com.br/bartofilcompany/accountcreated/index/

*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    #Utilizando a keyword Gerar Dados Fake Cadastro com Sucesso
    Gerar Dados Fake Cadastro com Sucesso
    # Aguardar exibir o elemento Razao Social
    Wait Until Element Is Visible    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}    5s

E clicar em Aceito receber informações de acordo com a Politica de Segurança
    # Clicar no Checkbox do LGPD
    Click Element    ${NOVAEMPRESA_CHECKBOX_LGPD}       

E clicar em Criar Conta
    #Clicar no botao Criar Conta
    Click Element    ${NOVAEMPRESA_BUTTON_CRIARCONTA}

Entao mensagem ${NOVAEMPRESA_MENSAGEM_CONTACRIADA_SUCESSO} é exibida
    Wait Until Page Contains   ${URL_ESPERADA_CADASTRO_SUCESSO}    10s