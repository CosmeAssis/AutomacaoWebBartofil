*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Home_Locators.yml
Variables   ../Data/Login.yml

*** Keywords ***
Dado que acesso o site do parceiro Bartofil
    # Acesso ao site do Bartofil B2B
    Go To    ${URL_BARTOFIL_B2B}
    # Clicar no botao Permitir Cookies apos acessar o site
    Wait Until Element Is Visible    ${HOME_BUTTON_PERMITIRCOOKIES}    5s
    Click Button    ${HOME_BUTTON_PERMITIRCOOKIES}
    
Quando clicar em Olá! Entre ou cadastra-se 
    # Clicar no botao Login no Header do site
    Click Element    ${HOME_LINK_CUSTOMERLOGIN}
    # Aguardar esperar aparecer o modal do login
    Wait Until Element Is Visible    ${HOME_MODALTITLE_JASOUCLIENTE}    5s

E preencher login e senha
    # Digitar o CPF no login
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_APROVADA}
    # Digitar a senha no login
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}

E clicar em Entrar
    # Realizar o click no botao Login
    Click Button    ${HOME_BUTTON_LOGIN}

Então o Minha Conta será exibido no header
    # Aguardar exibir o icone Minha Conta no header
    Wait Until Element Is Visible    ${HOME_HEADER_MINHACONTA}  5s

E preencher login e senha de uma conta em aprovação
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_EM_APROVACAO}
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}  

Então mensagem que a conta ainda não foi aprovada é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_CONTANAOAPROVADA}    5s

E preencher com uma senha incorreta
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ_EMPRESA_APROVADA}
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD_INVALIDO}    

Então mensagem informando que Login e Senha é inválido é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_LOGINSENHAINVALIDO}    5s

E realizo o login com sucesso
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha
    E clicar em Entrar
    Então o Minha Conta será exibido no header

Quando pesquisar o produto com SKU ${SKU}
    Input Text    ${HOME_INPUT_BUSCAPRODUTO}    ${SKU}
    Wait Until Element Is Visible    ${HOME_GRID_RESULTADOPRODUTO}    10s
    Sleep    3s
    Click Element    ${HOME_GRID_RESULTADOPRODUTO}