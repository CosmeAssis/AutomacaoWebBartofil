*** Settings ***
Resource         ../resource.robot

*** Variables ***
${browser}           chrome
${url}                https://mcstaging.bartofil.com.br/

*** Keywords ***

Abrir o navegador
    Open Browser   browser=${browser}
    Maximize Browser Window

Abrir Navegador no Celular
    Open Browser   browser=${browser}
    Set Window Size    430    932

Fechar o navegador
    Close Browser