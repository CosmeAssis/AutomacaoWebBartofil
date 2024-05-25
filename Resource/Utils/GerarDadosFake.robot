*** Settings ***
Resource          ../Resource.robot
Variables    ../Locators/NovaEmpresaLocators.yml
Variables    ../Data/NovaEmpresaInputText.yml

*** Variables ***
${NOME_FAKE}    ${EMPTY}
${MAX_TENTATIVAS}    10
${CAMPO_ERRO_CNPJ}    CNPJ inválido

*** Keywords ***
Gerar Dados Fake Cadastro com Sucesso
    ${FIRSTNAME_FAKE}    FakerLibrary.First Name
    ${LASTNAME_FAKE}    FakerLibrary.Last Name
    ${EMAIL_FAKE}    FakerLibrary.Company Email
    ${WHATSAPP_FAKE}    FakerLibrary.Phone Number
    ${PASSWORD_FAKE}    FakerLibrary.Password

     # Loop que tenta inserir o CNPJ até o número máximo de tentativas
    FOR    ${i}    IN RANGE    ${MAX_TENTATIVAS}
        ${CNPJ_FAKE}        FakerLibrary.Cnpj
        
        # Insere o CNPJ no campo correspondente
        Input Text    ${NOVAEMPRESA_INPUT_CNPJ}    ${EMPTY}
        Press Keys    ${NOVAEMPRESA_INPUT_CNPJ}    ${CNPJ_FAKE}
        Click Element    //strong[contains(.,'Preencha o CNPJ para confirmação dos Dados')]
        # Aguarda 5 segundo para permitir que a página processe a busca
        Sleep    5s
        # Verifica se existe uma mensagem de erro indicando que o CNPJ é inválido
        ${erro_cnpj_visivel}    Run Keyword And Return Status    Element Should Be Visible    ${CAMPO_ERRO_CNPJ}
        # Obtém o valor do campo "Razão Social"
        ${razao_social}    Get Value    ${NOVAEMPRESA_INPUT_RAZAOSOCIAL}
        # Obtém o valor do campo "Nome Fantasia"
        ${nome_fantasia}    Get Value    ${NOVAEMPRESA_INPUT_NOMEFANTASIA}
        # Verifica se ambos os campos estão preenchidos
        Run Keyword If    '${razao_social}' != '' and '${nome_fantasia}' != ''    Log    Campos preenchidos corretamente na tentativa ${i+1}
        # Se ambos os campos estiverem preenchidos, encerra a execução da palavra-chave
        Run Keyword If    '${razao_social}' != '' and '${nome_fantasia}' != ''    Return From Keyword
        # Loga uma mensagem informando que os campos ainda não foram preenchidos
        Log    Tentativa ${i+1}: Campos ainda não preenchidos
    END
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