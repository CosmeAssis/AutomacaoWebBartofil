*** Settings ***
Resource        ../Utils/OpenBrowser.robot
Variables       ../Locators/HomeLocators.yml
Variables       ../Data/DadosTeste.yml


*** Keywords ***
Dado que estou na página inicial do site www.bartofil.com.br
    # Acesso ao site do Bartofil B2B
    Go To    ${URL_BARTOFIL_B2B}
    # Clicar no botao Permitir Cookies apos acessar o site
    Wait Until Element Is Visible    ${HOME_BUTTON_PERMITIRCOOKIES}    10s
    Click Button    ${HOME_BUTTON_PERMITIRCOOKIES}

Quando clicar em Olá! Entre ou cadastra-se
    # Clicar no botao Login no Header do site
    Click Element    ${HOME_LINK_CUSTOMERLOGIN}
    # Aguardar esperar aparecer o modal do login
    Wait Until Element Is Visible    ${HOME_MODALTITLE_JASOUCLIENTE}    10s

E preencher login e senha
    [Arguments]    ${CNPJ}    ${PASSWORD}
    # Digitar o CPF no login
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ}
    # Digitar a senha no login
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}

E clicar em Entrar
    # Realizar o click no botao Login
    Click Button    ${HOME_BUTTON_LOGIN}

Então o Minha Conta será exibido no header
    # Aguardar exibir o icone Minha Conta no header
    Sleep    10s
    Wait Until Element Is Visible    ${HOME_HEADER_MINHACONTA}

Então mensagem que a conta ainda não foi aprovada é exibida
    # Aguardar exibir a mensagem que a conta ainda nao foi aprovada
    Wait Until Element Is Visible    ${HOME_MESSAGE_CONTANAOAPROVADA}    10s

Então mensagem informando que Login e Senha é inválido é exibida
    # Aguardar exibir a mensagem que o login ou senha é invalido
    Wait Until Element Is Visible    ${HOME_MESSAGE_LOGINSENHAINVALIDO}    10s

E realizo o login com sucesso
    Quando clicar em Olá! Entre ou cadastra-se
    E preencher login e senha    ${CNPJ_EMPRESA_APROVADA}    ${PASSWORD_VALIDO}
    E clicar em Entrar
    Então o Minha Conta será exibido no header

Quando pesquisar o produto com SKU ${SKU}
    # Digitar    o SKU no produto na busca de produto
    Input Text    ${HOME_INPUT_BUSCAPRODUTO}    ${SKU}
    # Aguardar exibir o produto na busca de produto
    Wait Until Element Is Visible    ${HOME_GRID_RESULTADOPRODUTO}    10s
    Sleep    3
    # Clicar no produto apresentado na busca de produto
    Click Element    ${HOME_GRID_RESULTADOPRODUTO}

E clicar em Cadastrar
    # Clicar no botao Cadastrar
    Click Element    ${HOME_BUTTON_CADASTRAR}
