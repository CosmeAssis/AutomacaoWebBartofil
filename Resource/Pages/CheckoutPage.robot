*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Checkout_Locators.yml

*** Variables ***
${CARACTERE_REMOVER_CIFRAO}    R$

*** Keywords ***
Atualizar Pagina metodo de pagamento Boleto Antecipado
    Execute JavaScript    location.reload(true)
    Sleep    3
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Click Button    //input[contains(@value,'getnet_paymentmagento_boleto')]
    Sleep    3

E selecionar o metodo de pagamento como Boleto Antecipado
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}
    Sleep    3
    Click Element    ${CHECKOUT_BUTTON_CONTINUAR}
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Click Button    //input[contains(@value,'getnet_paymentmagento_boleto')]

E verificar o desconto de 3%
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY}  # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       # Substituir "," por "."
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    ${desconto_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)
    ${valor_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${desconto_calculado},2)
    Atualizar Pagina metodo de pagamento Boleto Antecipado
    ${VALOR_PEDIDO_ATUALIZADO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_PEDIDO_ATUALIZADO}    Replace String   ${VALOR_PEDIDO_ATUALIZADO}    ,    .
    ${valor_calculado}    Convert To String    ${valor_calculado}
    Should Contain   ${VALOR_PEDIDO_ATUALIZADO}    ${valor_calculado}

E clicar em Finalizar Compra
    Sleep    3
    Scroll Element Into View        (//button[contains(@title,'Finalizar Compra')])[5]
    #Wait Until Element Is Visible       (//button[contains(@title,'Finalizar Compra')])[5]
    Click Button    (//button[@title='Finalizar Compra'])[5]