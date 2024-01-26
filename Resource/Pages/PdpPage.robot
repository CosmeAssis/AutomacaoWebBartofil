*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/PDP_Locators.yml
Resource          ../Resource.robot

*** Keywords ***
E validar tela de PDP
    Wait Until Element Is Visible  ${PDP_PAGETITLE_PRODUTO}
    Wait Until Element Is Visible  ${PDP_IMAGE_PDP}
    Wait Until Element Is Visible  ${PDP_ITEMPROP_SKUPRODUTO}

E adicionar o produto no carrinho