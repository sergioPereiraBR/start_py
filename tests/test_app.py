from app import start


def test_app():
    entrada = start()
    esperado = 0
    assert entrada == esperado
