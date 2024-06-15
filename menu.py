import database, main, planeta
import stargate as stargate

def start(conexao):
    mostrar_menu()
    escolha = obter_escolha_usuario()
    processar_escolha(escolha, conexao)
    

def mostrar_menu():
    print(38 * "=")
    print("    SISTEMA DE CONSULTA GATE ADMIN    ")
    print(38 * "=")
    print("Escolha uma entidade para obter informações:")
    print("1. Stargates")
    print("2. Planetas")
    print("3. Sair")
    print(38 * "=")
    print("Digite o número da sua escolha e pressione Enter:")

def obter_escolha_usuario():
    while True:
        try:
            escolha = int(input())
            if 1 <= escolha <= 3:
                return escolha
            else:
                print("Por favor, insira um número entre 1 e 5.")
        except ValueError:
            print("Entrada inválida. Por favor, insira um número.")

def processar_escolha(escolha, conexao):
    if escolha == 1:
        print("Você escolheu Stargates.")
        stargate.menu(conexao)
        # Adicione sua lógica aqui
    elif escolha == 2:
        print("Você escolheu Planetas.")
        planeta.menu(conexao) 
    elif escolha == 3:
        main.sair(conexao)

def limpar_tela():
    # Limpa a tela (funciona em sistemas Unix e Windows)
    import os
    os.system('cls' if os.name == 'nt' else 'clear')

def verificar_int(valor):
    try:
        valor = int(valor)
        return valor
    except ValueError:
        return valor