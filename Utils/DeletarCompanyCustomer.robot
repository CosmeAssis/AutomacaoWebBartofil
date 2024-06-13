*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../DATA/NovaEmpresaInputText.yml
Variables       ../Data/DadosTeste.yml


*** Variables ***
${BASE_URL}     https://mcstaging.bartofil.com.br/


*** Keywords ***
Criar Sessão API B2B Staging
    Create Session    apibartofilstaging    ${BASE_URL}

Consultar Customers com Parâmetros
    [Arguments]    ${field}    ${value}    ${headers}
    # Cria o dicionário de parâmetros com os critérios de busca
    ${params}=    Create Dictionary
    ...    searchCriteria[filter_groups][0][filters][0][field]=${field}
    ...    searchCriteria[filter_groups][0][filters][0][value]=${value}
    # Faz a requisição GET na sessão configurada
    ${response}=    GET On Session
    ...    apibartofilstaging
    ...    rest/all/V1/customers/search
    ...    headers=${headers}
    ...    params=${params}
    # Loga o conteúdo da resposta
    Log    ${response.content}
    # Converte a resposta JSON de string para dicionário
    ${response_json}=    Evaluate    json.loads('${response.content}')    json

    # Verifica se há itens na resposta
    ${items}=    Get From Dictionary    ${response_json}    items
    IF    '$items' == 'None'    RETURN    None

    # Obtém o company_id do primeiro item, se disponível
    ${first_item}=    Get From List    ${items}    0
    ${extension_attributes}=    Get From Dictionary    ${first_item}    extension_attributes
    ${company_attributes}=    Get From Dictionary    ${extension_attributes}    company_attributes
    ${company_id}=    Get From Dictionary    ${company_attributes}    company_id
    RETURN    ${company_id}

Deletar Company pelo Company ID
    [Arguments]    ${company_id}    ${headers}
    # Configura a URL para a requisição DELETE
    ${url}=    Set Variable    /rest/V1/company/${company_id}?deleteCustomerId=true
    # Faz a requisição DELETE na sessão configurada
    ${response}=    DELETE On Session    apibartofilstaging    ${url}    headers=${headers}
    # Loga o status code e o conteúdo da resposta
    Log    ${response.status_code}
    Log    ${response.content}

Executar Consulta e Deleção de Company
    [Arguments]    ${cnpj}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN_API}
    # Consulta o customer com o CNPJ fornecido
    ${company_id}=    Consultar Customers com Parâmetros    taxvat    ${cnpj}    ${headers}
    # Verifica se o company_id é None, caso seja, loga a mensagem e finaliza. Caso contrário, deleta a company.
    IF    '$company_id' == 'None'    # Sintaxe ajustada aqui
        Log    Nenhuma empresa encontrada para o CNPJ: ${cnpj}
    ELSE
        Deletar Company pelo Company ID    ${company_id}    ${headers}
    END
