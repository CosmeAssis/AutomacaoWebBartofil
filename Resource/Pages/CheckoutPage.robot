*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Checkout_Locators.yml
Variables    ../Data/CheckoutInputText.yml

*** Keywords ***

E selecionar o metodo de pagamento como Boleto Antecipado
    # Aguardar exibir a Label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    5s
    # Aguadar exibir o metodo de pagamento Boleto Antecipado
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_BOLETOANTECIPADO}    5s
    # Scroll ate o metodo de pagamento Boleto Antecipado
    Scroll Element Into View    ${CHECKOUT_CHOICEPAYMENT_BOLETOANTECIPADO}
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
    Scroll Element Into View    ${CHECKOUT_ACTIONS_TOOLBAR_BOLETOANTECIPADO}
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
    Click Button    ${CHECKOUT_BUTTON_FINALIZARCOMPRA_BOLETO_ANTECIPADO}

Entao mensagem ${CHECKOUT_MENSAGEM_PEDIDOREALIZADO} é exibida
    Sleep    3
    # Aguardar exibir do pedido realizado com sucesso
    Wait Until Page Contains    ${CHECKOUT_MENSAGEM_PEDIDOREALIZADO}

E selecionar o metodo de pagamento como Pix
    # Aguadar exibir a label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    5s
    # Aguadar exibir o metodo de pagamento Pix
    Wait Until Element Is Visible     ${CHECKOUT_RADIOBUTTON_PIX}    5s
    # Scroll até o metodo de pagamento Pix
    Scroll Element Into View    ${CHECKOUT_RADIOBUTTON_PIX}
    Sleep    3
    
Entao o desconto de 3% do Pix é verificado
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
    Limpar Carrinho a partir do checkout

E selecionar o metodo de pagamento como Cartao de Credito
    # Aguardar exibir a label Resumo do Pedido
    Wait Until Element Is Visible    ${CHECKOUT_LABEL_RESUMODOPEDIDO}    5s
    Sleep    3
    # Clicar no metodo de pagamento Cartao de Credito
    Click Element    ${CHECKOUT_RADIOBUTTON_CARTAOCREDITO}
    Wait Until Element Is Visible    ${CHECKOUT_RADIOBUTTON_CARTAOCREDITO}    5s

E clicar para nao utilizar o programa de ponto do parceiro
    Wait Until Element Is Visible    ${CHECKOUT_DATABIND_REMOVERPONTOSPARCEIRO}   5s
    Click Element    ${CHECKOUT_DATABIND_REMOVERPONTOSPARCEIRO}  
    Wait Until Element Is Visible    ${CHECKOUT_MESSAGE_PONTOSPARCEIROREMOVIDO}    5s

E digitar as informacoes do cartao
    # Inserir o numero do cartao de credito
    Input Text    ${CHECKOUT_INPUT_NUMEROCARTAODECREDITO}    ${CHECKOUT_NUMEROCARTAODECREDITO}
    # Inserir o cvv do cartao de credito
    Input Text    ${CHECKOUT_INPUT_CVV}    ${CHECKOUT_CVV}
    Sleep    3
    # Clicar no mes de vencimento do cartao de credito
    Click Element    ${CHECKOUT_DROPLIST_MESVENCIMENTO}
    Click Element    ${CHECKOUT_DROPLIST_MESMARCO}
    # Clicar no ano de vencimento do cartao de credito 
    Click Element    ${CHECKOUT_DROPLIST_ANOVENCIMENTO}
    Click Element    ${CHECKOUT_DROPLIST_ANO2030}
    # Digitar nome do cliente do cartao de credito
    Input Text    ${CHECKOUT_INPUT_NOMETITULARCARTAO}    ${CHECKOUT_NOMECLIENTE}
    Click Element    ${CHECKOUT_DROPLIST_PARCELAMENTO}
    Click Element    ${CHECKOUT_DROPLIST_OPCAOPARCELAMENTO}

Limpar Carrinho a partir do checkout
    Go To    https://mcstaging.bartofil.com.br/checkout/cart/
    Scroll Element Into View    ${CHECKOUT_BUTTON_EXCLUIRSELECIONADOS}
    Click Element    //span[contains(.,'Selecionar tudo')]
    Click Element    ${CHECKOUT_BUTTON_EXCLUIRSELECIONADOS}