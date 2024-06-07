*** Settings ***
Resource    ../Utils/Resource.robot


*** Variables ***
${BROWSER}              chrome
${URL_BARTOFIL_B2B}     https://mcstaging.bartofil.com.br/


*** Keywords ***
Abrir o navegador
    Open BROWSER    browser=${BROWSER}
    Maximize BROWSER Window

Abrir Navegador no Celular
    Open BROWSER    browser=${BROWSER}
    Set Window Size    430    932

Fechar o navegador
    Close BROWSER
