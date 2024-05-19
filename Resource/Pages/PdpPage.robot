*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/PDP_Locators.yml
Variables   ../Locators/Checkout_Locators.yml
Resource    ../Resource.robot

*** Variables ***
${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}

*** Keywords ***

E validar tela de PDP
    # Aguardar o titulo do produto está visivel na PDP
    Wait Until Element Is Visible  ${PDP_PAGETITLE_PRODUTO}    10s
    # Aguardar a imagem do produto está visivel na PDP
    Wait Until Element Is Visible  ${PDP_IMAGE_PDP}    10s
    # Aguardar o SKU do produto está visivel na PDP
    Wait Until Element Is Visible  ${PDP_ITEMPROP_SKUPRODUTO}    10s

E adicionar o produto no carrinho
    # Realizar o scroll na pagina ate exibir a label com a desc do produto na PDP
    Scroll Element Into View    ${PDP_LABEL_DESCPRODUTO}
    # Clicar na quantidade de produto 4 vezes na PDP
    FOR    ${index}    IN RANGE    4
        Click Element    ${PDP_BUTTON_ADICIONAR_QUANTIDADE_PRODUTO}
    END
    # Clicar no botao Adicionar ao Carrinho na PDP
    Click Button    ${PDP_BUTTON_ADDCARRINHO}
    # Guardar na variavel a descricao do produto da PDP
    ${PDP_NOME_PRODUTO}    Get Text    ${PDP_LABEL_NOMEPRODUTO}
    # Verificar o nome do produto na mensagem de adicionado ao carrinho
    Set Global Variable     ${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}    //div[@data-bind='html: $parent.prepareMessageForHtml(message.text)'][contains(.,'${PDP_NOME_PRODUTO}')]
    Page Should Contain  ${PDP_NOME_PRODUTO}    ${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}
    # Aguardar exibir o botao Ver Carrinho
    Wait Until Element Is Visible    ${PDP_BUTTON_VERCARRINHO}
    # Scroll na pagina até o botao Ver Carrinho
    Scroll Element Into View    ${PDP_BUTTON_VERCARRINHO}
    # Clicar no botao Ver Carrinho
    Click Button    ${PDP_BUTTON_VERCARRINHO}
    ### INICIO DA TELA DE CHECKOUT
    # Clicar no botao Fechar Pedido
    Click Element    ${PDP_BUTTON_FECHARPEDIDO}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_NEXTSTEP}    10s
    Sleep    5
    Click Element    ${CHECKOUT_BUTTON_NEXTSTEP}
    Wait Until Element Is Enabled    ${CHECKOUT_DATABIND_REMOVERPONTOSPARCEIRO}   