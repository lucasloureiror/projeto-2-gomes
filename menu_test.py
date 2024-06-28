import unittest
import menu

class TestFunctions(unittest.TestCase):

    def test_verificar_int(self):
        # Teste com um valor que pode ser convertido para inteiro
        self.assertEqual(menu.verificar_int("123"), 123)
        # Teste com um valor que não pode ser convertido para inteiro
        self.assertEqual(menu.verificar_int("abc"), "abc")
        # Teste com um valor que já é inteiro
        self.assertEqual(menu.verificar_int(456), 456)

    def test_processar_escolha(self):
        import stargate
        import planeta
        import main
        from unittest.mock import patch

        conexao = "dummy_connection"

        with patch('stargate.menu') as mock_stargate_menu:
            menu.processar_escolha(1, conexao)
            mock_stargate_menu.assert_called_once_with(conexao)

        with patch('planeta.menu') as mock_planeta_menu:
            menu.processar_escolha(2, conexao)
            mock_planeta_menu.assert_called_once_with(conexao)

        with patch('main.sair') as mock_main_sair:
            menu.processar_escolha(3, conexao)
            mock_main_sair.assert_called_once_with(conexao)

if __name__ == '__main__':
    unittest.main()
