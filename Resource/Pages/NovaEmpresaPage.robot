*** Settings ***
Resource    ../Resource.robot
Resource    ../Utils/OpenBrowser.robot
Resource    ../Utils/GerarDadosFake.robot

*** Keywords ***
E preencher as informacoes de cadastro com sucesso
    Gerar Dados Fake Cadastro do Cadastro