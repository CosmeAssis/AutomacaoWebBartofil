*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../DATA/NovaEmpresaInputText.yml
Variables       ../Data/DadosTeste.yml


*** Variables ***
${BASE_URL}     https://mcstaging.bartofil.com.br/


*** Keywords ***
Criar Sessão API B2B Staging
    Create Session    apibartofilstaging    ${BASE_URL}

Consultar Company ID pelo CNPJ
    [Arguments]    ${field}    ${value}    ${headers}

    # Criando o dicionário de parâmetros para a requisição GET
    ${params}=    Create Dictionary
    ...    searchCriteria[filter_groups][0][filters][0][field]=${field}
    ...    searchCriteria[filter_groups][0][filters][0][value]=${value}

    # Fazendo a requisição GET para a API
    ${response}=    GET On Session
    ...    apibartofilstaging    # Nome da sessão ou endpoint da API
    ...    rest/all/V1/customers/search    # Caminho para o endpoint de pesquisa de clientes
    ...    headers=${headers}    # Passando os cabeçalhos
    ...    params=${params}    # Passando os parâmetros

    # Logando o conteúdo da resposta (opcional, para debug)
    Log    ${response.content}

    # Convertendo a resposta de JSON para um dicionário Python
    ${response_json}=    Evaluate    json.loads($response.content)    json
    # Obtendo a lista de items da resposta
    ${items}=    Get From Dictionary    ${response_json}    items
    # Obtendo o tamanho da lista de items
    ${items_count}=    Get Length    ${items}

    # Verificando se a lista de items está vazia
    IF    '${items_count}' == '0'    RETURN    None

    # Pegando o primeiro item da lista
    ${first_item}=    Set Variable    ${items}[0]
    # Obtendo os extension_attributes do primeiro item
    ${extension_attributes}=    Get From Dictionary    ${first_item}    extension_attributes
    # Obtendo os company_attributes dos extension_attributes
    ${company_attributes}=    Get From Dictionary    ${extension_attributes}    company_attributes
    # Obtendo o company_id dos company_attributes
    ${company_id}=    Get From Dictionary    ${company_attributes}    company_id
    # Retornando o company_id encontrado
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

Executar Consulta e Delete da Company
    [Arguments]    ${cnpj}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN_API}
    
    # Consulta o customer com o CNPJ fornecido
    ${company_id}=    Consultar Company ID pelo CNPJ    taxvat    ${cnpj}    ${headers}
    
    # Verifica se o company_id não é None usando Run Keyword If
    Run Keyword If    '${company_id}' != 'None'
    ...    Deletar Company pelo Company ID    ${company_id}    ${headers}
    Log    Empresa deletada com sucesso
    
    # Se o company_id for None, registra um log apropriado
    Run Keyword If    '${company_id}' == 'None'
    ...    Log    Nenhuma empresa encontrada para o CNPJ: ${cnpj}

##################### AJUSTAR APOS CRIACAO DA API PARA DELETAR PELO CRISTIAN ##############################

Consultar ID do Parceiro pelo CNPJ
    [Arguments]    ${field}    ${value}    ${headers}
    ${params}=    Create Dictionary
    ...    searchCriteria[filter_groups][0][filters][0][field]=${field}
    ...    searchCriteria[filter_groups][0][filters][0][value]=${value}
    ${response}=    Get On Session
    ...    apibartofilstaging
    ...    /rest/V1/parceiro/list
    ...    headers=${headers}
    ...    params=${params}
    Should Be Equal As Strings    ${response.status_code}    200
    ${json_response}=    Set Variable    ${response.json()}
    Log    Response JSON: ${json_response}

    ${items}=    Get From Dictionary    ${json_response}    items
    ${first_item}=    Set Variable    ${items}[0]
    ${parceiro_id}=    Get From Dictionary    ${first_item}    parceiro_id
    Log    Parceiro ID encontrado: ${parceiro_id}
    RETURN    ${parceiro_id}

Deletar Parceiro pelo Parceiro ID
    [Arguments]    ${parceiro_id}    ${headers}
    # Configurar a URL para a requsicao DELETE
    ${url}=    Set Variable    /rest/all/V1/bartofil_parceiro/parceiro/delete/${parceiro_id}/1/
    # Faz a requesicao POST
    ${response}=    POST On Session    apibartofilstaging    ${url}    headers=${headers}
    # Loga o status code e o conteúdo da resposta
    Log    ${response.status_code}
    Log    ${response.content}

Executar Consulta e Delete do Parceiro
    [Arguments]    ${cnpj}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN_API}
    ${parceiro_id}=    Consultar ID do Parceiro pelo CNPJ    cnpj    ${cnpj}    ${headers}
    # Verifica se o PARCEIRO_ID é None, caso seja, loga a mensagem e finaliza. Caso contrário, deleta o parceiro.
    IF    '$parceiro_id' == 'None'    # Sintaxe ajustada aqui
        Log    Nenhuma empresa encontrada para o CNPJ: ${cnpj}
    ELSE
        Deletar Parceiro pelo Parceiro ID    ${parceiro_id}    ${headers}
    END
