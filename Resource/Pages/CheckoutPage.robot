*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Checkout_Locators.yml

*** Variables ***
${CARACTERE_REMOVER_CIFRAO}    R$

*** Keywords ***
E selecionar o metodo de pagamento como Boleto Antecipado
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}
    Sleep    3
    Click Element    ${CHECKOUT_BUTTON_CONTINUAR}
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}

E verificar o desconto de 3%
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY}  # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       # Substituir "," por "."
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    ${desconto_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)
    ${valor_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${desconto_calculado},2)
    Execute JavaScript    location.reload(true)
    Sleep    3
    ${VALOR_PEDIDO_ATUALIZADO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${valor_calculado}    Convert To String    ${valor_calculado}
    Should Not Be Equal As Strings    ${VALOR_PEDIDO_ATUALIZADO}    ${valor_calculado}

E clicar em Finalizar Compra
    Wait Until Element Is Visible    //button[@title='Finalizar Compra'])[5]
    Click Button    (//button[@title='Finalizar Compra'])[5]