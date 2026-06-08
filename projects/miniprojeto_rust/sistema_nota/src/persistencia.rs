use serde_json;
use crate::aluno::Aluno;
use std::fs::File;

pub fn salvar_arquivo(vetor_aluno: &Vec<Aluno>) -> Result<(), Box<dyn std::error::Error>>{
    println!("Vetor de alunos: {:#?}", vetor_aluno);

    // Primeiro serializar o vetor de alunos em JSON
    let j = serde_json::to_string_pretty(&vetor_aluno)?;

    // Escreve em um arquivo
    std::fs::write("alunos.json", j)?;

    Ok(())
}

pub fn carregar_arquivo() -> Result<Vec<Aluno>, Box<dyn std::error::Error>> {
    println!("Carregando arquivo...");

    // Abre o arquivo
    let f = File::open("alunos.json")?;

    // Deserializa o arquivo 
    let dados: Vec<Aluno> = serde_json::from_reader(f)?;
    
    
    println!("Alunos carregados: {:#?}", dados);
    Ok(dados)

}




