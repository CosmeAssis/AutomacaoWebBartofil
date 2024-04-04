*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/PDP_Locators.yml
Variables   ../Locators/Checkout_Locators.yml
Resource    ../Resource.robot

*** Variables ***
${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}

*** Keywords ***

E validar tela de PDP
    Wait Until Element Is Visible  ${PDP_PAGETITLE_PRODUTO}
    Wait Until Element Is Visible  ${PDP_IMAGE_PDP}
    Wait Until Element Is Visible  ${PDP_ITEMPROP_SKUPRODUTO}

E adicionar o produto no carrinho
    Scroll Element Into View    ${PDP_LABEL_DESCPRODUTO}
    FOR    ${index}    IN RANGE    4
        Click Element    ${PDP_BUTTON_ADICIONAR_QUANTIDADE_PRODUTO}
    END
    Click Button    ${PDP_BUTTON_ADDCARRINHO}
    ${DESC_PRODUTO}    Get Text    ${PDP_LABEL_NOMEPRODUTO}
    Set Global Variable     ${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}    //div[@data-bind='html: $parent.prepareMessageForHtml(message.text)'][contains(.,'${DESC_PRODUTO}')]
    Page Should Contain  ${DESC_PRODUTO}    ${PDP_MENSAGEM_PRODUTOADDAOCARRINHO}
    Wait Until Element Is Visible    ${PDP_BUTTON_VERCARRINHO}
    Scroll Element Into View    ${PDP_BUTTON_VERCARRINHO}
    Click Button    ${PDP_BUTTON_VERCARRINHO}
    Click Element    ${PDP_BUTTON_FECHARPEDIDO}
    # Inicio tela de checkout
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_NEXTSTEP}
    Sleep    3
    Click Element    ${CHECKOUT_BUTTON_NEXTSTEP}
    #Wait Until Element Is Visible    //div[contains(@class,'opc-wrapper')]
    Wait Until Element Is Enabled    //input[@data-bind='click: removeRewardPoints']   
    #Click Element    //input[@data-bind='click: removeRewardPoints']
    #Wait Until Element Is Visible    //div[@class='opc-payment']