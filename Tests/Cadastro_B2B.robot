*** Settings ***
Resource    ../Resource/Utils/OpenBrowser.robot
Resource    ../Resource/Pages/HomePage.robot
##Execução antes de iniciar o teste
Test Setup       Abrir o navegador
##Execução após execução do teste
Test Teardown    Fechar o navegador

*** Test Cases ***

CN0001-Realizar cadastro de cliente Pessoa Juridica com sucesso no B2B
    Dado que acesso o site do parceiro Bartofil
    Quando clicar em Olá! Entre ou cadastra-se
    E clicar em Cadastrar
    E verificar que está selecionado a opcao Pessoa Juridica
    E clicar em Proxima Etapa
    E preencher as informacoes de cadastro
    E clicar em Aceito receber informações de acordo com a Politica de Segurança (Lei Geral de Proteção de Dados)
    E clicar em Criar Conta
    Entao mensagem Conta criada com sucesso! é exibida
