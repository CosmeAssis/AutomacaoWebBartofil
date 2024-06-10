*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../Locators/NovaEmpresaLocators.yml
Variables       ../Data/NovaEmpresaInputText.yml
Library         CustomLibrary.py


*** Variables ***
${NOME_FAKE}            ${EMPTY}
${MAX_TENTATIVAS}       10
# Define o localizador do elemento de carregamento (loading) usando XPath
${LOADING_ELEMENT}      xpath=//*[@id="html-body"]/div[1]/div/img


*** Keywords ***
Gerar Dados Fake Cadastro com Sucesso
    FOR    ${i}    IN RANGE    ${MAX_TENTATIVAS}
        ${CNPJ_FAKE}    Generate Valid Cnpj

        # Insere o CNPJ no campo correspondente
        Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
        Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${CNPJ_FAKE}
        Click Element    //input[contains(@name,'company[company_email]')]
        # Espera até que o elemento de carregamento desapareça
        Wait Until Element Is Not Visible    ${LOADING_ELEMENT}    60s
        # Executa a palavra-chave personalizada para esperar até que o campo "Razão Social" seja preenchido
        # Continua o teste mesmo se ela falhar
        ${result}    Run Keyword And Ignore Error    Wait Until Element Is Filled    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}
        # Aguarda 10 segundos para permitir que a página processe a busca
        Sleep    10s
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
    Preencher demais campos do cadastro

Preencher demais campos do cadastro
    ${FIRSTNAME_FAKE}    FakerLibrary.First Name
    ${LASTNAME_FAKE}    FakerLibrary.Last Name
    ${EMAIL_FAKE}    FakerLibrary.Company Email
    ${WHATSAPP_FAKE}    FakerLibrary.Phone Number
    # Se o loop terminar e os campos não estiverem preenchidos, falha o teste
    Input Text    ${NOVAEMPRESA_INPUT_APELIDO}    ${FIRSTNAME_FAKE}
    Set Global Variable    ${NOME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_COMPANYEMAIL}    ${EMAIL_FAKE}
    Set Global Variable    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_CUSTOMEREMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_FIRSTNAME}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_LASTNAME}    ${LASTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_WHATSAPP}    ${WHATSAPP_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORD}    ${PASSWORD_CADASTRO}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORDCONFIRMATION}    ${PASSWORD_CADASTRO}

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
