import database, main, menu as m, planeta as p
from prettytable import PrettyTable

class Stargate:
    def __init__(self, endereco, status_stargate, planeta):
        self.endereco = endereco
        self.status_stargate = status_stargate
        self.planeta = planeta

    def validar(self):
        # Verifica se o endereço tem 8 caracteres
        if len(self.endereco) != 8:
            return False
        if len(self.status_stargate) > 20:
            return False
        return True
        
    def __repr__(self):
        return f"Stargate(endereco='{self.endereco}', status_stargate='{self.status_stargate}', planeta={self.planeta})"

def menu(conexao):
    while True:
        m.limpar_tela()
        print(38 * "=")
        print("Menu do Stargate")
        print(38 * "=")
        print("Escolha uma operação:")
        print("1. Listar todos os Stargates")
        print("2. Buscar Stargate")
        print("3. Inserir Stargate")
        print("4. Retornar")
        print("5. Sair")
        print(38 * "=")
        print("Digite o número da sua escolha e pressione Enter:")
        try:
            escolha = int(input())
            if 1 <= escolha <= 5:
                processar_escolha(escolha, conexao)
            else:
                print("Por favor, insira um número entre 1 e 3.")
        except ValueError:
            print("Entrada inválida. Por favor, insira um número.")


def processar_escolha(escolha, conexao):
    if escolha == 1:
        print("Você escolheu listar todos os stargates.")
        listar(conexao)

    elif escolha == 2:
        m.limpar_tela()
        print("Escolha o parâmetro de busca:")
        print("1. Endereço")
        print("2. Status do Stargate")
        print("3. ID do Planeta")
        print("4. Nome do Planeta")
        print("5. Por Galáxia")
        print("6. Por Sistema Estelar")
        escolha = input("Digite o número do parâmetro: ")

        parametro = ""
        if escolha == "1":
            parametro = "endereco"
        elif escolha == "2":
            parametro = "status_stargate"
        elif escolha == "3":
            parametro = "planeta"
        elif escolha == "4":
            parametro = "nome"
        elif escolha == "5":
            parametro = "galaxia"
        elif escolha == "6":
            parametro = "sistema"
        else:
            print("Escolha inválida")
            return

        valor = input(f"Digite o valor para {parametro}: ")
        if parametro is not "endereco":
            valor = m.verificar_int(valor)
        buscar(conexao, parametro, valor)
    elif escolha == 3:
        m.limpar_tela()
        print("Você escolheu inserir Stargate.")
        endereco = input("Digite o endereco do Stargate: ")
        status = input("Digite o Status do Stargate: ")
        planeta = input("Digite o ID numérico ou o nome do planeta: ")
        planeta = m.verificar_int(planeta)
        if isinstance(planeta, str):
            resultado = p.buscar_planeta(conexao, "nome", planeta)
            if len(resultado) > 1:
                m.limpar_tela()
                print("Mais de um planeta foi encontrado com esse nome, a inserção deverá ser feita por ID!")
                input("Aperte enter para voltar ao menu")
                return
            else:
                planeta = resultado[0].id_planeta
        
        novo_stargate = Stargate(endereco, status, planeta)
        inserir(conexao, novo_stargate)
    elif escolha == 4:
        m.limpar_tela()
        m.start(conexao)
        
        # Adicione sua lógica aqui
    elif escolha == 5:
        main.sair(conexao)
        

def listar(conexao):
    query = "SELECT s.endereco, s.status_stargate, s.planeta, p.nome AS nome_planeta FROM Stargate s LEFT JOIN Planeta p ON s.planeta = p.id_planeta;"
    registros, erro = database.consulta(conexao, query, None)
    if erro is not None:
        print("Ocorreu um erro na listagem dos Stargates", erro)
        input("Pressione enter para continuar")
        return

    # Criar uma lista de tuplas (Stargate, nome_planeta)
    stargate_infos = []
    for registro in registros:
        endereco, status_stargate, planeta, nome_planeta = registro
        stargate = Stargate(endereco, status_stargate, planeta)
        stargate_infos.append((stargate, nome_planeta))

    m.limpar_tela()
    print("Listando todos os stargates")
    imprimir_stargates(stargate_infos)


def imprimir_stargates(stargate_infos, fields=None):
    tabela = PrettyTable()
    tabela.field_names = ["Endereço","Nome do Planeta", "ID Planeta", "Status",]

    for info in stargate_infos:
        # Verifica se 'info' é uma instância de Stargate ou uma tupla
        if isinstance(info, Stargate):
            stargate = info
            nome_planeta = "N/A"  # Caso seja um objeto Stargate, não temos o nome do planeta
        elif isinstance(info, tuple) and len(info) == 2 and isinstance(info[0], Stargate):
            stargate, nome_planeta = info
            nome_planeta = nome_planeta if nome_planeta else "Não se aplica"
            stargate.planeta = stargate.planeta if stargate.planeta else "Não se aplica"
        else:
            continue  # Ignora entradas inválidas

        tabela.add_row([stargate.endereco, nome_planeta, stargate.planeta, stargate.status_stargate])

    print(tabela)
    print("Faça a análise dos dados, anote o que for necessário e aperte enter para retornar ao menu.")
    input()


def buscar(conexao, parametro, valor):
    # Define os parâmetros possíveis para as tabelas Stargate e Planeta
    parametros_stargate = {'endereco', 'status_stargate', "planeta"}
    parametros_planeta = {'galaxia', 'sistema', 'nome'}


    # Constrói a consulta com base no parâmetro
    if parametro in parametros_stargate:
        campo = f"s.{parametro}"
    elif parametro in parametros_planeta:
        campo = f"p.{parametro}"

    # Verifica se o valor é uma instância de string
    if isinstance(valor, str):
        valor = valor.upper()  # Converte o valor para uppercase para comparação agnóstica ao case
        query = f"SELECT s.endereco, s.status_stargate, s.planeta, p.nome AS nome_planeta FROM Stargate s LEFT JOIN Planeta p ON s.planeta = p.id_planeta WHERE upper({campo}) = %s"
    else:
        query = f"SELECT s.endereco, s.status_stargate, s.planeta, p.nome AS nome_planeta FROM Stargate s LEFT JOIN Planeta p ON s.planeta = p.id_planeta WHERE ({campo}) = %s"

    registros, erro = database.consulta(conexao, query, valor)
    if erro is not None:
        print("Ocorreu um erro na consulta:", erro)
        input("Aperte enter para continuar")
        return

    stargate_infos = [(Stargate(endereco, status_stargate, id_planeta), nome_planeta) for endereco, status_stargate, id_planeta, nome_planeta in registros]

    m.limpar_tela()
    print(f"Exibindo resultados da busca de Stargate com {parametro} igual a {valor}")
    imprimir_stargates(stargate_infos)


def inserir(conexao, stargate):
    if not stargate.validar():
        input("Stargate não passou na validação de dados, aperte enter para sair")
        return
    valores = (stargate.endereco, stargate.status_stargate, stargate.planeta)
    query = "insert into stargate(endereco, status_stargate, planeta) values(%s, %s, %s);"
    resultado = database.insercao(conexao, query, valores)
    if resultado is not True:
        print("Ocorreu um erro na inserção do stargate: ", resultado)
        input("Aperte enter para continuar")
        return
    
    print("\nStargate inserido com sucesso!")
    input("Aperte enter para continuar")
        
