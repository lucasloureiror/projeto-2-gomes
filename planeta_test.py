import unittest
from unittest.mock import patch
from planeta import Planeta
from planeta import processar_escolha

class TestPlaneta(unittest.TestCase):

    def test_validar_campos_vazios(self):
        planeta = Planeta(1, "", "Sistema Solar", "Terra", "Rochoso", "Alta", "Habitado")
        self.assertFalse(planeta.validar())

    def test_validar_campos_excedem_limite(self):
        nome_longo = "a" * 101
        planeta = Planeta(1, "Via Láctea", "Sistema Solar", nome_longo, "Rochoso", "Alta", "Habitado")
        self.assertFalse(planeta.validar())

    def test_validar_campos_validos(self):
        planeta = Planeta(1, "Via Láctea", "Sistema Solar", "Terra", "Rochoso", "Alta", "Habitado")
        self.assertTrue(planeta.validar())


if __name__ == '__main__':
    unittest.main()
