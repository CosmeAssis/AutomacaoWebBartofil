*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../DATA/NovaEmpresaInputText.yml
Variables    ../Data/DadosTeste.yml


*** Variables ***
${BASE_URL}     https://mcstaging.bartofil.com.br/


*** Keywords ***
Criar Sessão
    Create Session    apibartofilstaging    ${BASE_URL}

Consultar Customers com Parâmetros
    [Arguments]    ${field}    ${value}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN_API}
    ${params}=    Create Dictionary
    ...    searchCriteria[filter_groups][0][filters][0][field]=${field}
    ...    searchCriteria[filter_groups][0][filters][0][value]=${value}
    ${response}=    GET On Session
    ...    apibartofilstaging
    ...    rest/all/V1/customers/search
    ...    headers=${headers}
    ...    params=${params}
    Log    ${response.content}
    ${response_json}=    To JSON    ${response.content}
    ${company_id}=    Set Variable
    ...    ${response_json['items'][0]['extension_attributes']['company_attributes']['company_id']}
    RETURN    ${company_id}

Deletar Company pelo Company ID
    [Arguments]    ${company_id}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN_API}
    ${url}=    Set Variable    /rest/V1/company/${company_id}?deleteCustomerId=true
    ${response}=    DELETE On Session    apibartofilstaging    ${url}    headers=${headers}
    Log    ${response.status_code}
    Log    ${response.content}

Executar Consulta e Deleção de Company
    [Arguments]    ${cnpj}
    ${company_id}=    Consultar Customers com Parâmetros    taxvat    ${cnpj}
    Log    Company ID: ${company_id}
    Deletar Company pelo Company ID    ${company_id}
