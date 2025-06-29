# -*- coding: utf-8 -*-
"""Calculadora.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1rdaevCVEPlBGNnJXvmJWl-LNAguIDu8e

Vamos fazer uma função de calculadora que será chamada depois.

1. O programa irá perguntar o primeiro número que o usuário quer escrever.

2. O programa irá perguntar qual operação que ele quer.

3. O programa irá perguntar o segundo número.
4. O programa irá efetuar o cálculo desses dois números e irá retornar o resultado. Também irá estocar o resultado na memória usando lista.
5. Irá perguntar se o usuário quer continuar fazendo a operação ou irá querer interromper.
6. Caso queira continuar calculando, o valor calculado será a primeira variável e assim segue a operação. Caso não queira continuar, o programa prontamente irá retornar o input e a memória.
"""

# Calculadora em Python

# Desenvolva uma calculadora em Python com tudo que você aprendeu nos capítulos até aqui no curso.
# A solução será apresentada no próximo capítulo!

print("\n******************* Calculadora em Python *******************")

def operadora(n1, operador, n2):
  # Fazer a operação
  if operador == "+":
    resultado = n1+n2
  elif operador == "-":
    resultado = n1-n2
  elif operador == "*":
    resultado = n1*n2
  elif operador == "/":
    if n2 == 0:
      print("Não é possível dividir por zero")
      return None
    else:
      resultado = n1/n2
  else:
    print("Operador inválido")
  return resultado


def calculadora():
  # Lista vazia para armazenar os resultados
  memoria = []

  # Pedir o input do usuário
  n1 = float(input("Digite o primeiro número:"))
  operador = input("Digite o operador (+, -, *, /):")
  n2 = float(input("Digite o segundo número:"))

  # Chamar a função
  resultado = operadora(n1, operador, n2)

  # Retornar resultado
  print(f"O resultado é {resultado}")
  memoria.append(resultado)

  # Perguntar se quer continuar a operação
  continuar = input("Deseja continuar com as operações (s/n): ")
  if continuar == "s":
    while True:

      # Efetuar as outras operações
      operador = input("Digite o operador (+, -, *, /):")
      n2 = float(input("Digite o segundo número:"))

      # Importar a função de calcular
      resultado = operadora(resultado, operador, n2)

      # Retornar resultado e estocar na memória
      print(f"O resultado é {resultado}")
      memoria.append(resultado)

      # Perguntar se quer continuar a operação
      continuar = input("Deseja continuar com as operações (s/n): ")
      if continuar == "n":
        print("Até a próxima!")
        return resultado, memoria
        break
  else:
    print("Até a próxima!")
    return resultado, memoria

teste_resultado, teste_memória = calculadora()
print("Segue o último resultado: %r \nAqui está a sequência dos resultados: %r" %(teste_resultado, teste_memória))