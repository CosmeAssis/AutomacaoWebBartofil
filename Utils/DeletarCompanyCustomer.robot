*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       https://mcstaging.bartofil.com.br/
${TOKEN}          7nd7pr0ol02dduqq91k1lw8a4ug597s5
${CNPJ}           53104962000157

*** Keywords ***
Obter Company ID pelo CNPJ
    [Documentation]    Obtém o company_id a partir do CNPJ
    [Arguments]        ${cnpj}
    # Cria uma sessão para fazer chamadas HTTP para a URL base
    Create Session    apibartofilstaging    ${BASE_URL}
    # Cria um dicionário de cabeçalhos com o token de autorização
    ${headers}=        Create Dictionary    Authorization=Bearer ${TOKEN}
    # Cria um dicionário de parâmetros para a consulta com o CNPJ
    ${params}=         Create Dictionary    searchCriteria[filter_groups][0][filters][0][field]=taxvat    searchCriteria[filter_groups][0][filters][0][value]=${cnpj}
    # Faz uma requisição GET na sessão criada para a rota de busca de clientes, passando os cabeçalhos e os parâmetros
    ${response}=       GET On Session    apibartofilstaging    /rest/all/V1/customers/search    headers=${headers}    params=${params}
    # Converte a resposta JSON para um dicionário
    ${data}=           Set Variable    ${response.json()}
    # Obtém a lista de itens do dicionário de dados
    ${items}=          Get From Dictionary    ${data}    items
    # Obtém o primeiro item da lista de itens
    ${first_item}=     Get From List    ${items}    0
    # Obtém o valor do campo "extension_attributes" do primeiro item
    ${extension_attributes}=    Get From Dictionary    ${first_item}    extension_attributes
    # Obtém o valor do campo "company_attributes" do "extension_attributes"
    ${company_attributes}=    Get From Dictionary    ${extension_attributes}    company_attributes
    # Obtém o valor do campo "company_id" do "company_attributes"
    ${company_id}=    Get From Dictionary    ${company_attributes}    company_id
    # Retorna o company_id
    [Return]           ${company_id}

*** Test Cases ***
Obter Company ID pelo CNPJ
    # Chama a palavra-chave para obter o company_id usando o CNPJ definido nas variáveis
    ${company_id}=    Obter Company ID pelo CNPJ    ${CNPJ}
    # Loga o company_id obtido
    Log               Company ID: ${company_id}
