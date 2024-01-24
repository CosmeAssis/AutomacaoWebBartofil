*** Settings ***
Resource    ../Utils/OpenBrowser.robot
Variables   ../Locators/Home_Locators.yml
Variables   ../Data/Login.yml

*** Keywords ***
Dado que acesso o site do parceiro Bartofil
    Go To    ${url}
    Wait Until Element Is Visible    ${StoreLogo}    timeout=10s
    
Quando clicar em Olá! Entre ou cadastra-se 
    Click Element    ${LinkCustomerLogin}
    Wait Until Element Is Visible    ${ModalJaSouCliente}    timeout=10s

E preencher login e senha
    Input Text    ${InputUsernameLogin}    ${CNPJ_Empresa_Aprovada}
    Input Password    ${InputPasswordLogin}    ${Password}

E clicar em Entrar
    Click Button    ${ButtonLogin}

Então o Minha Conta será exibido no header
    Wait Until Element Is Visible    ${HOME_HEADER_MINHACONTA}  timeout=10s

E preencher login e senha de uma conta em aprovação
    Input Text    ${InputUsernameLogin}    ${CNPJ_Empresa_EmAprovacao}
    Input Password    ${InputPasswordLogin}    ${Password}  

Então mensagem que a conta ainda não foi aprovada é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_CONTANAOAPROVADA}    timeout=10s

E preencher com uma senha incorreta
    Input Text    ${InputUsernameLogin}    ${CNPJ_Empresa_Aprovada}
    Input Password    ${InputPasswordLogin}    ${Password_Invalido}    

Então mensagem informando que Login e Senha é inválido é exibida
    Wait Until Element Is Visible    ${HOME_MESSAGE_LOGINSENHAINVALIDO}    timeout=10s