*** Settings ***
Resource          ../Resource.robot
Variables    ../Locators/NovaEmpresa_Locators.yml

*** Variables ***
${NOME_FAKE}    ${EMPTY}

*** Keywords ***
Gerar Dados Fake Cadastro do Cadastro
    ${NOME_FAKE}    FakerLibrary.Name

    Input Text    ${NOVAEMPRESA_INPUT_APELIDO}    ${NOME_FAKE}


