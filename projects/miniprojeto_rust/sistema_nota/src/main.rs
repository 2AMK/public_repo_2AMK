mod utils;
mod persistencia;
mod aluno;
mod menu;
mod options;

use crate::aluno::Aluno;
use crate::persistencia::carregar_arquivo;
use crate::menu::programa_sistema_nota;

fn main() {
    println!("Hello, world!");
    // Carregando arquivo caso exista, se não existir, cria um novo
    let mut vetor_alunos: Vec<Aluno> = carregar_arquivo().unwrap_or(Vec::new());

    //Construindo um sistema de nota
    let vetor_alunos = programa_sistema_nota(&mut vetor_alunos);
    
    // Imprimindo o vetor de alunos
    println!("Vetor de alunos: {:#?}", vetor_alunos);
}


