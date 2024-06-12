*** Settings ***
Resource        ../Utils/Resource.robot
Resource        ../Utils/OpenBrowser.robot
Resource        ../Utils/GerarDadosFake.robot
Variables       ../Data/NovaEmpresaInputText.yml
Variables       ../Locators/NovaEmpresaLocators.yml


*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    # Insere o CNPJ no campo correspondente
    Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
    Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${CNPJ_CADASTRO}
    Click Element    //input[contains(@name,'company[company_email]')]
    # Espera até que o elemento de carregamento desapareça
    Wait Until Element Is Not Visible    ${LOADING_ELEMENT}    60s
    # Utilizando a keyword Gerar Dados Fake Cadastro com Sucesso
    Gerar Dados Fake Cadastro com Sucesso
    # Aguardar exibir o elemento Razao Social
    Wait Until Element Is Visible    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}    5s

E clicar em Aceito receber informações de acordo com a Politica de Segurança
    # Clicar no Checkbox do LGPD
    Click Element    ${NOVAEMPRESA_CHECKBOX_LGPD}

E clicar em Criar Conta
    # Clicar no botao Criar Conta
    Click Element    ${NOVAEMPRESA_BUTTON_CRIARCONTA}

Entao mensagem ${NOVAEMPRESA_MENSAGEM_CONTACRIADA_SUCESSO} é exibida
    Sleep    3
    # Aguardar exibir mensagem de conta criada com sucesso
    Wait Until Page Contains    ${NOVAEMPRESA_MENSAGEM_CONTACRIADA_SUCESSO}
