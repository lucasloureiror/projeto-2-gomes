import unittest
from unittest.mock import patch, MagicMock
import main

class TestMainModule(unittest.TestCase):

    @patch('main.menu.limpar_tela')
    @patch('main.database.start_connection')
    @patch('main.menu.start')
    def test_main(self, mock_menu_start, mock_start_connection, mock_limpar_tela):

        mock_connection = MagicMock()
        mock_start_connection.return_value = mock_connection

        main.main()

        mock_limpar_tela.assert_called_once()
        mock_start_connection.assert_called_once()
        mock_menu_start.assert_called_once_with(mock_connection)

    @patch('main.exit')
    def test_sair(self, mock_exit):

        mock_connection = MagicMock()

        main.sair(mock_connection)

        
        mock_connection.close.assert_called_once()

        mock_exit.assert_called_once()

if __name__ == '__main__':
    unittest.main()
