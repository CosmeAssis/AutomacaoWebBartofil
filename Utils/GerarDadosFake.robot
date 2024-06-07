*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../Locators/NovaEmpresaLocators.yml
Variables       ../Data/NovaEmpresaInputText.yml
Library         CustomLibrary.py


*** Variables ***
${NOME_FAKE}            ${EMPTY}
${MAX_TENTATIVAS}       10
${CAMPO_ERRO_CNPJ}      CNPJ inválido


*** Keywords ***   
Gerar Dados Fake Cadastro com Sucesso
    FOR    ${i}    IN RANGE    ${MAX_TENTATIVAS}
    ${CNPJ_FAKE}        Generate Valid Cnpj
    
    # Insere o CNPJ no campo correspondente
    Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
    Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${CNPJ_FAKE}
    Click Element    //input[contains(@name,'company[nickname]')]
    # Aguarda 5 segundos para permitir que a página processe a busca
    Sleep    5s
    # Obtém o valor do campo "Razão Social"
    ${razao_social}    Get Value    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}
    # Obtém o valor do campo "Nome Fantasia"
    ${nome_fantasia}    Get Value    ${NOVAEMPRESA_INPUT_NOMEFANTASIA}
    # Verifica se ambos os campos estão preenchidos corretamente
    Run Keyword If    '${razao_social}' != '' and '${nome_fantasia}' != ''
    ...    Exit For Loop
    ...    ELSE IF    ${i+1} == ${MAX_TENTATIVAS}
    ...    Log    Tentativas esgotadas. Não foi possível preencher os campos.
    END
    Preencher demais campos do cadastro

Preencher demais campos do cadastro
    ${FIRSTNAME_FAKE}    FakerLibrary.First Name
    ${LASTNAME_FAKE}    FakerLibrary.Last Name
    ${EMAIL_FAKE}    FakerLibrary.Company Email
    ${WHATSAPP_FAKE}    FakerLibrary.Phone Number
    ${PASSWORD_FAKE}    FakerLibrary.Password
    # Se o loop terminar e os campos não estiverem preenchidos, falha o teste
    Input Text    ${NOVAEMPRESA_INPUT_APELIDO}    ${FIRSTNAME_FAKE}
    Set Global Variable    ${NOME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_COMPANYEMAIL}    ${EMAIL_FAKE}
    Set Global Variable    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_CUSTOMEREMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_FIRSTNAME}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_LASTNAME}    ${LASTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_WHATSAPP}    ${WHATSAPP_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORD}    ${PASSWORD_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORDCONFIRMATION}    ${PASSWORD_FAKE}
