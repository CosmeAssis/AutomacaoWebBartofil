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
    Capture Page Screenshot
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Capture Page Screenshot
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Capture Page Screenshot
    Sleep    3

E verificar o desconto de 3%
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY}  # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       # Substituir "," por "."
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    ${desconto_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)
    ${valor_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${desconto_calculado},2)
    ${valor_calculado}    Convert To String    ${valor_calculado}
    ${valor_calculado}    Replace String    ${valor_calculado}    .    ,
    Click Button    //input[contains(@value,'getnet_paymentmagento_boleto')]
    Sleep    3
    Page Should Contain   ${valor_calculado}

E clicar em Finalizar Compra
    Sleep    3
    Scroll Element Into View        (//button[contains(@title,'Finalizar Compra')])[5]
    Click Button    (//button[@title='Finalizar Compra'])[5]

Entao mensagem ${MENSAGEM_PEDIDO_RECEBIDO} é exibida
    Wait Until Page Contains    ${MENSAGEM_PEDIDO_RECEBIDO}
    #Page Should Contain Element    ${MENSAGEM_PEDIDO_RECEBIDO}