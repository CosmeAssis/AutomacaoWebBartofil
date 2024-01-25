*** Settings ***
Resource          ../Resource.robot

*** Variables ***
${BROWSER}            headlesschrome
${URL_BARTOFIL}                https://mcstaging.bartofil.com.br/

*** Keywords ***

Abrir o navegador
    Open BROWSER   BROWSER=${BROWSER}
    Maximize BROWSER Window

Abrir Navegador no Celular
    Open BROWSER   BROWSER=${BROWSER}
    Set Window Size    430    932

Fechar o navegador
    Close BROWSER