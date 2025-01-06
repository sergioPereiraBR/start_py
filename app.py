"""This is the module docstring."""

from rich.console import Console


def start(test: str = '') -> int:
    """
    Informa o término da execução make.

    Parameters:
        test (str): O argumento 'test' é Usando apenas para teste.

    Returns:
       return (None): A chamada não tem valor retornado.

    Examples:
        >>> start()
            python app.py


            A estrutura inicial do projeto  foi criada com sucesso!!

            Para executar uma diretiva de comando:  make diretiva
            Para saber mais sobre as  diretivas: make help


            .
    """
    console = Console()
    console.print(
        '\n\n[green]A estrutura inicial do projeto ',
        '[green]foi criada com sucesso!!\n',
    )
    console.print(
        'Para executar uma diretiva de comando: ',
        '[bold][yellow]make[white] diretiva[/bold]',
    )
    console.print(
        'Para saber mais sobre as ',
        'diretivas: [yellow]make[white] help\n\n',
    )

    return 1


if __name__ == '__main__':
    exit(start(''))
