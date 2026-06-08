use crate::aluno::Aluno;
use crate::utils::parser_stdin;
use crate::persistencia::salvar_arquivo;
use crate::options::{*};



#[derive(PartialEq, Debug)]
enum Menu {
    CadastrarAluno,
    AdicionarNota,
    ListarAlunos,
    RemoverAluno,
    CalcularMediaAluno,
    CalcularMediaGlobal,
    CalcularSituacaoAluno,
    SalvarArquivo,
    Sair,
    OpcaoInvalida
}



pub fn programa_sistema_nota(vetor_aluno: &mut Vec<Aluno>) -> &mut Vec<Aluno> {
    println!("Bem vindo ao sistema de notas");
    

    //
    loop {
        println!("Escolha uma opção abaixo:");

        // Menu
        println!("1 - Cadastrar Aluno");
        println!("2 - Adicionar Nota");
        println!("3 - Listar Alunos");
        println!("4 - Remover Aluno");
        println!("5 - Calcular Media Aluno");
        println!("6 - Calcular Media Global");
        println!("7 - Calcular Situação Aluno");
        println!("8 - Salvar Arquivo");
        println!("9 - Sair");

        //Output do Usuário
        let opcao: String  = parser_stdin();
        let opcao: &str = opcao.as_str();

        let result_opcao = match opcao {
            "1" => Menu::CadastrarAluno,
            "2" => Menu::AdicionarNota,
            "3" => Menu::ListarAlunos,
            "4" => Menu::RemoverAluno,
            "5" => Menu::CalcularMediaAluno,
            "6" => Menu::CalcularMediaGlobal,
            "7" => Menu::CalcularSituacaoAluno,
            "8" => Menu::SalvarArquivo,
            "9" => Menu::Sair,
            _ => Menu::OpcaoInvalida
        };

        if result_opcao == Menu::OpcaoInvalida {
            println!("Essa opção não existe. Por favor escolha uma opção válida");
            continue;
        }

        if result_opcao == Menu::Sair {
            println!("Saindo do programa");
            return vetor_aluno;

        } else {
            println!("Opção escolhida: {}", opcao);
            let vetor_aluno_result = match_result_opcao(result_opcao, vetor_aluno);
            println!("Vetor de alunos: {:#?}", vetor_aluno_result);
            continue;
        }
        
    };

}


// Função que irá lidar com as opções
fn match_result_opcao(result_opcao:Menu, vetor_aluno: &mut Vec<Aluno>, ) -> &mut Vec<Aluno> {

        //Match das Opções
        match result_opcao {
            Menu::CadastrarAluno => {
                println!("Insira o nome do aluno: ");
                let nome: String = parser_stdin();
                println!("Insira a nota do aluno: ");
                let nota: u8 = parser_stdin();
                let aluno_cadastrado = cadastrar_aluno(nome, nota); 
                vetor_aluno.push(aluno_cadastrado);
                vetor_aluno
            },
            Menu::AdicionarNota => {
                println!("Insira o nome do aluno: ");
                let nome: String = parser_stdin();
                println!("Insira a nota do aluno: ");
                let nota: u8 = parser_stdin();
                let adicionar_nota = adicionar_nota(vetor_aluno, nome, nota);
                adicionar_nota
            },
            Menu::ListarAlunos => {
                listar_alunos(&vetor_aluno);
                vetor_aluno
            },
            Menu::RemoverAluno => {
                let nome: String = parser_stdin();
                let vetor_aluno = remover_aluno(nome, vetor_aluno);
                vetor_aluno
            },
            Menu::CalcularMediaAluno => {
                println!("Insira o nome do aluno: ");
                let nome: String = parser_stdin();
                let calcular_media = calcular_media_aluno(&vetor_aluno, nome);
                println!("Media: {}", calcular_media.unwrap_or(0.0));
                vetor_aluno
            },
            Menu::CalcularMediaGlobal => {
                calcular_media_global(vetor_aluno); 
                vetor_aluno 
            },
            Menu::CalcularSituacaoAluno => {
                println!("Insira o nome do aluno: ");
                let nome: String = parser_stdin();
                calcular_situacao_aluno(&vetor_aluno, nome);
                vetor_aluno
            }
            Menu::SalvarArquivo => {
                match salvar_arquivo(&vetor_aluno) {
                    Ok(_) => println!("Arquivo salvo com sucesso"),
                    Err(e) => println!("Erro ao salvar o arquivo: {}", e)
                };
                vetor_aluno
            },
            Menu::Sair => {
                println!("Saindo do programa");
                vetor_aluno
            }
            _ => {
                println!("Opção inválida");
                vetor_aluno
            }
        }
}
