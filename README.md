# Desafio Lista de compras

![GitHub top language](https://img.shields.io/github/languages/top/Wendller/shopping_list_challenge)
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/Wendller/shopping_list_challenge/Elixir%20CI)
![](https://img.shields.io/badge/excoveralls-100%25-green)

## Descrição

Desenvolver uma função que receberá uma lista de compras e
uma lista de e-mails. Aqui, cada e-mail representa uma pessoa.

A função deve:

- [x] Validar que não exista algum e-mail duplicado.
- [x] Validar que nenhuma das listas esteja vazia.
- [x] Calcular a soma dos valores, ou seja, multiplicar o preço de cada item por sua quantidade e
      somar todos os itens.
- [x] Validar que a quantidade e valor de um item não sejam negativos.
- [x] Dividir o valor de forma igual entre a quantidade de e-mails.
- [x] Retornar um mapa/dicionário onde a chave será o e-mail e o valor será quanto ele deve pagar
      nessa conta.
- [x] Ter testes unitários.

## Instalação

Para executar o programa, é necessário ter o Elixir instalado, para Linux e Mac você pode instalar via [adsf](https://asdf-vm.com/#/core-manage-asdf). A instalação padrão pode ser feita de acordo com o site [oficial](https://elixir-lang.org/install.html).

Ao final de tudo, você pode conferir a versão através do comando:

```bash
elixir -v
```

## Execução

Uma vez instalado o elixir, você pode clonar o projeto e se certificar de que baixou as dependências necessárias antes da execução dos testes.

```bash
# Clonando o repositório
git clone https://github.com/Wendller/shopping_list_challenge.git

# Mova para o repositório
cd shopping_list_challenge

# Instale as dependências
mix deps.get
```

## Testes

Execute os testes através do comando:

```bash
mix test --cover

| Percentage  | Module                     |
| ----------- | -------------------------- |
| 100.00%     | Items                      |
| 100.00%     | ShoppingListChallenge      |
| ----------- | -------------------------- |
| 100.00%     | Total                      |
```
