from rich.console import Console


def start(test: str = '') -> None:
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
        f'\n\n[green]A estrutura inicial do projeto ',
        f'[green]foi criada com sucesso!!\n',
    )
    console.print(
        f'Para executar uma diretiva de comando: ',
        f'[bold][yellow]make[white] diretiva[/bold]',
    )
    console.print(
        f'Para saber mais sobre as ',
        f'diretivas: [yellow]make[white] help\n\n',
    )


start('')
