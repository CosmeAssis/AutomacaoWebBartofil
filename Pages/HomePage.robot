*** Settings ***
Resource        ../Utils/OpenBrowser.robot
Resource        ../Pages/MinhaContaPage.robot
Resource        ../Pages/CriarContaPage.robot
Resource        ../Pages/NovaEmpresaPage.robot
Variables       ../Locators/HomeLocators.yml
Variables       ../Data/DadosTeste.yml


*** Keywords ***
Dado que estou na página inicial do site www.bartofil.com.br
    # Acesso ao site do Bartofil B2B
    Go To    ${URL_BARTOFIL_B2B}
    # Clicar no botao Permitir Cookies apos acessar o site
    Wait Until Element Is Visible    ${HOME_BUTTON_PERMITIRCOOKIES}    10s
    Click Button    ${HOME_BUTTON_PERMITIRCOOKIES}

Quando o usuario realizar o login com o CNPJ e senha
    [Arguments]    ${CNPJ}    ${PASSWORD}
    # Clicar no botao Login no Header do site
    Click Element    ${HOME_LINK_CUSTOMERLOGIN}
    # Aguardar esperar aparecer o modal do login
    Wait Until Element Is Visible    ${HOME_MODALTITLE_JASOUCLIENTE}    10s
    # Digitar o CNPJ no login
    Input Text    ${HOME_INPUT_USERNAME}    ${CNPJ}
    # Digitar a senha no login
    Input Password    ${HOME_INPUT_PASSWORD}    ${PASSWORD}
    # Realizar o click no botao Login
    Click Button    ${HOME_BUTTON_LOGIN}

 Clicar em Olá! Entre ou cadastra-se
    # Clicar no botao Login no Header do site
    Click Element    ${HOME_LINK_CUSTOMERLOGIN}
    # Aguardar esperar aparecer o modal do login
    Wait Until Element Is Visible    ${HOME_MODALTITLE_JASOUCLIENTE}    10s

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

E pesquisar o produto com SKU ${SKU}
    Então o Minha Conta será exibido no header
    # Digitar    o SKU no produto na busca de produto
    Input Text    ${HOME_INPUT_BUSCAPRODUTO}    ${SKU}
    # Aguardar exibir o produto na busca de produto
    Wait Until Element Is Visible    ${HOME_GRID_RESULTADOPRODUTO}    10s
    Sleep    3
    # Clicar no produto apresentado na busca de produto
    Click Element    ${HOME_GRID_RESULTADOPRODUTO}

Clicar em Cadastrar
    # Clicar no botao Cadastrar
    Click Element    ${HOME_BUTTON_CADASTRAR}

E o usuário clica em "Minha Conta"
    Então o Minha Conta será exibido no header
    # Clicar no elemento minha Conta
    Click Element    ${HOME_HEADER_MINHACONTA}
    Aguardar exibir o titulo da pagina Minha Conta

Quando preencher as informacoes do cadastro
    Clicar em Olá! Entre ou cadastra-se
    Clicar em Cadastrar
    Verificar que está selecionado a opcao Pessoa Juridica
    Clicar em Proxima Etapa
    Preencher as informacoes de cadastro com sucesso
    Clicar em Aceito receber informações de acordo com a Politica de Segurança
