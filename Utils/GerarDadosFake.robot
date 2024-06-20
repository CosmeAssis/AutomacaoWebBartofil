*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../Locators/NovaEmpresaLocators.yml
Variables       ../Data/NovaEmpresaInputText.yml
Variables       ../Locators/CadastrarParceiroLocators.yml
Variables       ../Data/CadastrarParceiroInputText.yml
Library         CustomLibrary.py


*** Keywords ***
Gerar Dados Fake Cadastro com Sucesso
    ${FIRSTNAME_FAKE}    FakerLibrary.First Name
    ${LASTNAME_FAKE}    FakerLibrary.Last Name
    ${EMAIL_FAKE}    FakerLibrary.Email
    ${CELLPHONE_FAKE}    FakerLibrary.Cellphone Number
    Input Text    ${NOVAEMPRESA_INPUT_APELIDO}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_COMPANYEMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_CUSTOMEREMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_FIRSTNAME}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_LASTNAME}    ${LASTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_WHATSAPP}    ${CELLPHONE_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORD}    ${PASSWORD_CADASTRO}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORDCONFIRMATION}    ${PASSWORD_CADASTRO}

Gerar Celular no Cadastro do Parceiro
    ${PHONE_FAKE_PARCEIRO}    FakerLibrary.Cellphone Number
    Input Text    ${MINHACONTA_INPUT_NUMERODEADMPARCEIRO}    ${PHONE_FAKE_PARCEIRO}
    Input Text    ${MINHACONTA_INPUT_WHATSPARCEIRO}    ${PHONE_FAKE_PARCEIRO}

Gerar Nome da Loja do Parceiro
    ${NOMEDALOJA_PARCEIRO}    FakerLibrary.Company
    Input Text    ${MINHACONTA_INPUT_NOMEDALOJA}    ${NOMEDALOJA_PARCEIRO}
    Input Text    ${MINHACONTA_INPUT_URLPARCEIRO}    ${URL_PARCEIRO_AUTOMACAO}
