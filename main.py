import database, menu


def main():
    menu.limpar_tela()
    conexao = database.start_connection()
    menu.start(conexao)

def sair(conexao):
    conexao.close()
    print("Conexão encerrada")
    exit()
    

if __name__ == "__main__":
    main()