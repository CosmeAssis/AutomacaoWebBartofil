*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Checkout_Locators.yml

*** Keywords ***

E selecionar o metodo de pagamento como Boleto Antecipado
    # Aguardar exibir a Label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    3s
    # Aguadar exibir o metodo de pagamento Boleto Antecipado
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}    3s
    # Scroll ate o metodo de pagamento Boleto Antecipado
    Scroll Element Into View    //div[@class='payment-method-title field choice'][contains(.,'Boleto Antecipado - 3% de desconto')]
    Sleep    3

E verificar o desconto de 3% do Boleto Antecipado
    # Variavel para armazenar o Valor do Produto
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY} 
    # Substituir "," por "."
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    # Calcular e arrendorar o resultado para duas casas decimais  
    ${DESCONTO_CALCULADO}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)
    # Calcular e arrendorar o resultado para duas casas decimais 
    ${VALOR_PEDIDO_CALCULADO}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${DESCONTO_CALCULADO},2)    
    # Converter o valor numerico em String
    ${VALOR_PEDIDO_CALCULADO}    Convert To String    ${VALOR_PEDIDO_CALCULADO}
    # Substituir "," por "."
    ${VALOR_PEDIDO_CALCULADO}    Replace String    ${VALOR_PEDIDO_CALCULADO}    .    ,
    # Clicar no metodo de Pagamento Boleto Antecipado
    Click Button    ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}
    Scroll Element Into View    (//div[contains(@class,'actions-toolbar')])[11]
    Sleep    3
    # Verificar que o calculo de 3% foi aplicado com sucesso
    Page Should Contain   ${VALOR_PEDIDO_CALCULADO}

E clicar em Finalizar Compra
    Sleep    5
    # Scroll ate o botao Finalizar Compra na PDP
    Scroll Element Into View        ${CHECKOUT_BUTTON_FINALIZARCOMPRA}
    # Clicar no botao Finalizar Compra na PDP
    Click Button    ${CHECKOUT_BUTTON_FINALIZARCOMPRA}

E clicar em Finalizar Compra com Boleto Antecipado
    Sleep    5
    Click Button    (//button[contains(@class,'action primary checkout')])[3]

Entao mensagem ${CHECKOUT_MENSAGEM_PEDIDOREALIZADO} é exibida
    Sleep    3
    # Aguardar exibir do pedido realizado com sucesso
    Wait Until Page Contains    ${CHECKOUT_MENSAGEM_PEDIDOREALIZADO}

E selecionar o metodo de pagamento como Pix
    # Aguadar exibir a label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    3s
    # Aguadar exibir o metodo de pagamento Pix
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_PIX}    3s
    # Scroll até o metodo de pagamento Pix
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_PIX}
    Sleep    3
    
E verificar o desconto de 3% do Pix
    # Variavel para armazenar o Valor do Produto
    ${VALOR_ORIGINAL_PRODUTO}   Get Text    ${CHECKOUT_PRICE_VALORTOTALPEDIDO}
    # Remover "R$"
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    R$    ${EMPTY} 
    # Substituir "," por "."
    ${VALOR_ORIGINAL_PRODUTO}    Replace String    ${VALOR_ORIGINAL_PRODUTO}    ,    .       
    ${PERCENTUAL_DESCONTO}    Set Variable    0.03
    # Calcular e arrendorar o resultado para duas casas decimais  
    ${DESCONTO_CALCULADO}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} * ${PERCENTUAL_DESCONTO},2)
    # Calcular e arrendorar o resultado para duas casas decimais 
    ${VALOR_PEDIDO_CALCULADO}    Evaluate    round(${VALOR_ORIGINAL_PRODUTO} - ${DESCONTO_CALCULADO},2)    
    # Converter o valor numerico em String
    ${VALOR_PEDIDO_CALCULADO}    Convert To String    ${VALOR_PEDIDO_CALCULADO}
    # Substituir "," por "."
    ${VALOR_PEDIDO_CALCULADO}    Replace String    ${VALOR_PEDIDO_CALCULADO}    .    ,
    # Clicar no metodo de Pagamento Pix
    Click Button    ${CHECKOUT_RADIOBUTTON_PIX}
    Sleep    3
    # Verificar que o calculo de 3% foi aplicado com sucesso
    Page Should Contain   ${VALOR_PEDIDO_CALCULADO}

E selecionar o metodo de pagamento como Cartao de Credito
    # Aguardar exibir a label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    3s
    Sleep    3
    # Clicar no metodo de pagamento Cartao de Credito
    Click Element    ${CHECKOUT_RADIOBUTTON_CARTAOCREDITO}
    Wait Until Element Is Visible    ${CHECKOUT_RADIOBUTTON_CARTAOCREDITO}    3s

E clicar para nao utilizar o programa de ponto do parceiro
    Wait Until Element Is Visible    //input[@data-bind='click: removeRewardPoints']    3s
    Click Element    //input[@data-bind='click: removeRewardPoints']   
    Wait Until Element Is Visible    //div[@data-ui-id='checkout-cart-validationmessages-message-success'][contains(.,'You removed the reward points from this order.')]    3s

E digitar as informacoes do cartao
    # Inserir o numero do cartao de credito
    Input Text    //input[contains(@data-container,'cc-cc-number')]    5155901222280001
    # Inserir o cvv do cartao de credito
    Input Text    //input[contains(@class,'input-text cvv')]    321
    Sleep    3
    # Clicar no mes de vencimento do cartao de credito
    Click Element    //select[@name='payment[cc_exp_month]'][contains(@id,'expiration')]
    Click Element    //option[@value='3'][contains(.,'03 - março')]
    # Clicar no ano de vencimento do cartao de credito 
    Click Element    //select[contains(@name,'payment[cc_exp_year]')]
    Click Element    //option[@value='2030']
    # Digitar nome do cliente do cartao de credito
    Input Text    //input[@type='text'][contains(@id,'name')]    CLIENTE BARTOFIL
    Click Element    //select[@name='payment[cc_installments]'][contains(@id,'installments')]
    Click Element    (//option[contains(@value,'1')])[10]