*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Home_Locators.yml
Variables   ../Data/Login.yml

*** Keywords ***
Dado que acesso o site do parceiro Bartofil
    Go To    ${URL_BARTOFIL}
    Wait Until Element Is Visible    ${HOME_IMAGE_STORELOGO}    timeout=10s
    
Quando clicar em Olá! Entre ou cadastra-se 
    Click Element    ${HOME_LINK_CUSTOMERLOGIN}
    Wait Until Element Is Visible    ${HOME_MODALTITLE_JASOUCLIENTE}    timeout=10s

E preencher login e senha
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_APROVADA}
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}

E clicar em Entrar
    Click Button    ${HOME_BUTTON_LOGIN}

Então o Minha Conta será exibido no header
    Wait Until Element Is Visible    ${HOME_HEADER_MINHACONTA}  timeout=10s

E preencher login e senha de uma conta em aprovação
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_EM_APROVACAO}
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}  

Então mensagem que a conta ainda não foi aprovada é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_CONTANAOAPROVADA}    timeout=10s

E preencher com uma senha incorreta
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_APROVADA}
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD_INVALIDO}    

Então mensagem informando que Login e Senha é inválido é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_LOGINSENHAINVALIDO}    timeout=10s

E realizo o login com sucesso
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha
    E clicar em Entrar
    Então o Minha Conta será exibido no header

Quando pesquisar o produto com SKU ${SKU}
    Input Text    ${HOME_INPUT_BUSCAPRODUTO}    ${SKU}
    Wait Until Element Is Visible    ${HOME_GRID_RESULTADOPRODUTO}
    Sleep    3s
    Click Element    ${HOME_GRID_RESULTADOPRODUTO}