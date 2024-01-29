*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/PDP_Locators.yml
Resource    ../Resource.robot

*** Variables ***
${PRODUTO}
${DATA_BIND}    //div[@data-bind='html: $parent.prepareMessageForHtml(message.text)'][contains(.,'${PRODUTO}')]

*** Keywords ***

E validar tela de PDP
    Wait Until Element Is Visible  ${PDP_PAGETITLE_PRODUTO}
    Wait Until Element Is Visible  ${PDP_IMAGE_PDP}
    Wait Until Element Is Visible  ${PDP_ITEMPROP_SKUPRODUTO}

E adicionar o produto no carrinho
    Scroll Element Into View    locator=//div[@class='page-main-description product-full-width-section']
    Click Button    ${PDP_BUTTON_ADDCARINHO}
    ${PRODUTO}    Get Text    locator=//span[contains(@itemprop,'name')]