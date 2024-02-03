*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Checkout_Locators.yml

*** Keywords ***

E selecionar o metodo de pagamento como Boleto Antecipado
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}
    Sleep    3
    Click Element    ${CHECKOUT_BUTTON_CONTINUAR}
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Sleep    3

E verificar o desconto de 3% do Boleto Antecipado
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY}  # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       # Substituir "," por "."
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    ${desconto_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)   # Calcular e arrendorar o resultado para duas casas decimais  
    ${valor_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${desconto_calculado},2)    # Calcular e arrendorar o resultado para duas casas decimais 
    ${valor_calculado}    Convert To String    ${valor_calculado}
    ${valor_calculado}    Replace String    ${valor_calculado}    .    ,
    Click Button    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Sleep    3
    Page Should Contain   ${valor_calculado}

E clicar em Finalizar Compra
    Sleep    3
    Scroll Element Into View        ${CHECKOUT_BUTTON_FINALIZARCOMPRA}
    Click Button    ${CHECKOUT_BUTTON_FINALIZARCOMPRA}

Entao mensagem ${MENSAGEM_PEDIDO_RECEBIDO} é exibida
    Wait Until Page Contains    ${MENSAGEM_PEDIDO_RECEBIDO}

E selecionar o metodo de pagamento como Pix
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}
    Sleep    3
    Click Element    ${CHECKOUT_BUTTON_CONTINUAR}
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_PIX}
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_PIX}
    Sleep    3
    
E verificar o desconto de 3% do Pix
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY}  # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       # Substituir "," por "."
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    ${desconto_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)   # Calcular e arrendorar o resultado para duas casas decimais  
    ${valor_calculado}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${desconto_calculado},2)    # Calcular e arrendorar o resultado para duas casas decimais 
    ${valor_calculado}    Convert To String    ${valor_calculado}
    ${valor_calculado}    Replace String    ${valor_calculado}    .    ,
    Click Button    ${CHECKOUT_RADIOBUTTON_PIX}
    Sleep    3
    Page Should Contain   ${valor_calculado}