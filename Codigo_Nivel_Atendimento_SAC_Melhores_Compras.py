# Desafio 2: Classificação com Python: Classificar o nível de satisfação do atendimento feito pelo SAC

# Solicita a nota de satisfação do cliente
nota_satisfacao = int(input("De 0 a 100, qual nota você daria para o nosso atendimento? "))
if nota_satisfacao < 0 or nota_satisfacao > 100:
    print("Nota inválida! Digite um valor entre 0 e 100.")
elif nota_satisfacao >= 90 and nota_satisfacao <= 100:
    print("O atendimento foi de qualidade.")
elif nota_satisfacao >= 70:
    print("O atendimento foi neutro.")
else:
    print("O atendimento foi insatisfatório.")