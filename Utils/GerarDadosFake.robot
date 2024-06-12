*** Settings ***
Resource        ../Utils/Resource.robot
Variables       ../Locators/NovaEmpresaLocators.yml
Variables       ../Data/NovaEmpresaInputText.yml
Library         CustomLibrary.py


*** Variables ***
# Define o localizador do elemento de carregamento (loading) usando XPath
${LOADING_ELEMENT}      xpath=//*[@id="html-body"]/div[1]/div/img


*** Keywords ***
Gerar Dados Fake Cadastro com Sucesso
    ${FIRSTNAME_FAKE}    FakerLibrary.First Name
    ${LASTNAME_FAKE}    FakerLibrary.Last Name
    ${EMAIL_FAKE}    FakerLibrary.Company Email
    ${WHATSAPP_FAKE}    FakerLibrary.Phone Number
    # Se o loop terminar e os campos não estiverem preenchidos, falha o teste
    Input Text    ${NOVAEMPRESA_INPUT_APELIDO}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_COMPANYEMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_CUSTOMEREMAIL}    ${EMAIL_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_FIRSTNAME}    ${FIRSTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_LASTNAME}    ${LASTNAME_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_WHATSAPP}    ${WHATSAPP_FAKE}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORD}    ${PASSWORD_CADASTRO}
    Input Text    ${NOVAEMPRESA_INPUT_PASSWORDCONFIRMATION}    ${PASSWORD_CADASTRO}