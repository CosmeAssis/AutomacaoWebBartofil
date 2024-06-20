*** Settings ***
Resource        ../Utils/Resource.robot
Resource        ../Utils/OpenBrowser.robot
Resource        ../Utils/GerarDadosFake.robot
Resource        ../Utils/DeletarCompanyCustomer.robot
Variables       ../Data/NovaEmpresaInputText.yml
Variables       ../Locators/NovaEmpresaLocators.yml
Variables       ../Locators/NovaEmpresaLocators.yml


*** Variables ***
${MAX_TENTATIVAS}       10


*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    Criar Sessão API B2B Staging
    Executar Consulta e Deleção de Company    ${CNPJ_CADASTRO}

    FOR    ${i}    IN RANGE    ${MAX_TENTATIVAS}
        # Insere o CNPJ no campo correspondente
        Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
        Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${CNPJ_CADASTRO}
        Click Element    ${NOVAEMPRESA_INPUT_APELIDO}
        # Espera até que o elemento de carregamento desapareça
        Wait Until Element Is Not Visible    ${LOADING_ELEMENT}    60s
        # Executa a palavra-chave personalizada para esperar até que o campo "Razão Social" seja preenchido
        # Continua o teste mesmo se ela falhar
        ${result}    Run Keyword And Ignore Error    Wait Until Element Is Filled    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}
        # Aguarda 5 segundos para permitir que a página processe a busca
        Sleep    5s
        # Obtém o valor do campo "Razão Social"
        ${razao_social}    Get Value    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}
        # Obtém o valor do campo "Nome Fantasia"
        ${nome_fantasia}    Get Value    ${NOVAEMPRESA_INPUT_NOMEFANTASIA}
        # Verifica se ambos os campos estão preenchidos corretamente
        IF    '${razao_social}' != '' and '${nome_fantasia}' != ''
            BREAK
        ELSE IF    ${i+1} == ${MAX_TENTATIVAS}
            Log    Tentativas esgotadas. Não foi possível preencher os campos.
        END
    END
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

# Define uma palavra-chave personalizada para esperar até que um elemento seja preenchido

Wait Until Element Is Filled
    # Define os argumentos que a palavra-chave aceita
    [Arguments]    ${locator}
    # Tenta repetidamente verificar se o campo não está vazio, com 10 tentativas e intervalos de 1 segundo
    Wait Until Keyword Succeeds
    ...    10x
    ...    1s
    ...    Run Keyword And Return Status
    ...    Element Should Not Be Empty
    ...    ${locator}

# Define uma palavra-chave personalizada para verificar se um elemento não está vazio

Element Should Not Be Empty
    # Define os argumentos que a palavra-chave aceita
    [Arguments]    ${locator}
    # Obtém o valor do elemento localizado
    ${element_value}    Get Value    ${locator}
    # Verifica se o valor do elemento não está vazio
    Should Not Be Empty    ${element_value}
