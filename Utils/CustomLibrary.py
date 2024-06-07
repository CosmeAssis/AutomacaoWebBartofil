# Importa as bibliotecas necessárias
from robot.api.deco import (
    keyword,
)  # Importa o decorador para definir palavras-chave customizadas
from faker import Faker  # Importa a biblioteca Faker para gerar dados fictícios
from faker.providers import company  # Importa o provedor de dados de empresa do Faker
from validate_docbr import CNPJ  # Importa a classe CNPJ da biblioteca validate_docbr


# Define a classe da biblioteca customizada
class CustomLibrary:
    # Método construtor da classe
    def __init__(self):
        # Inicializa o objeto Faker com localização brasileira
        self.fake = Faker("pt_BR")
        # Adiciona o provedor de dados de empresa ao Faker
        self.fake.add_provider(company)

    # Define uma palavra-chave customizada para gerar CNPJ válido
    @keyword
    def generate_valid_cnpj(self):
        # Loop infinito até que um CNPJ válido seja gerado
        while True:
            # Gera um CNPJ aleatório usando o Faker
            cnpj = self.fake.cnpj()
            # Verifica se o CNPJ gerado é válido usando a função de validação da classe CNPJ
            if CNPJ().validate(cnpj):
                # Se for válido, retorna o CNPJ
                return cnpj
